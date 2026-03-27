package com.embabel.demo.mcp;

import static org.assertj.core.api.Assertions.assertThat;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URI;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.TimeUnit;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.Timeout;

/**
 * Integration test for the MCP server SSE endpoint.
 * Requires the application to be running on localhost:8080.
 */
@Timeout(30)
class McpServerIntegrationTest {

    private static final String SSE_URL = "http://localhost:8080/sse";
    private static final ObjectMapper MAPPER = new ObjectMapper();

    private static String messageEndpoint;
    private static BlockingQueue<JsonNode> sseMessages;
    private static Thread sseThread;

    @BeforeAll
    static void connectAndInitialize() throws Exception {
        sseMessages = new LinkedBlockingQueue<>();

        // Connect to SSE endpoint in a background thread
        var endpointReady = new LinkedBlockingQueue<String>();

        sseThread = Thread.ofVirtual().start(() -> {
            try {
                var connection = (HttpURLConnection) URI.create(SSE_URL).toURL().openConnection();
                connection.setRequestProperty("Accept", "text/event-stream");
                connection.setConnectTimeout(5000);
                connection.setReadTimeout(0); // no timeout, keep stream open

                try (var reader = new BufferedReader(
                        new InputStreamReader(connection.getInputStream(), StandardCharsets.UTF_8))) {
                    String eventType = null;
                    String line;
                    while ((line = reader.readLine()) != null) {
                        if (line.startsWith("event:")) {
                            eventType = line.substring(6).trim();
                        } else if (line.startsWith("data:")) {
                            var data = line.substring(5).trim();
                            if ("endpoint".equals(eventType)) {
                                if (data.startsWith("/")) {
                                    data = "http://localhost:8080" + data;
                                }
                                endpointReady.put(data);
                            } else if ("message".equals(eventType)) {
                                sseMessages.put(MAPPER.readTree(data));
                            }
                            eventType = null;
                        }
                    }
                }
            } catch (Exception e) {
                if (!Thread.currentThread().isInterrupted()) {
                    e.printStackTrace();
                }
            }
        });

        // Wait for the endpoint event
        messageEndpoint = endpointReady.poll(10, TimeUnit.SECONDS);
        assertThat(messageEndpoint).as("SSE endpoint event").isNotNull();

        // Initialize the MCP session
        var initParams = MAPPER.createObjectNode();
        initParams.put("protocolVersion", "2024-11-05");
        initParams.set("capabilities", MAPPER.createObjectNode());
        initParams.set("clientInfo",
                MAPPER.createObjectNode().put("name", "test-client").put("version", "1.0.0"));

        postJsonRpc("initialize", 1, initParams);
        var initResponse = waitForResponse(1);
        assertThat(initResponse.has("result")).as("initialize response").isTrue();

        // Send initialized notification
        var notification = MAPPER.createObjectNode()
                .put("jsonrpc", "2.0")
                .put("method", "notifications/initialized");
        postMessage(notification);
    }

    @AfterAll
    static void disconnect() {
        if (sseThread != null) {
            sseThread.interrupt();
        }
    }

    @Test
    void shouldListExpectedTools() throws Exception {
        postJsonRpc("tools/list", 10, MAPPER.createObjectNode());
        var response = waitForResponse(10);

        assertThat(response.has("result")).as("tools/list has result").isTrue();
        var tools = response.get("result").get("tools");
        assertThat(tools.isArray()).isTrue();

        List<String> toolNames = new ArrayList<>();
        for (JsonNode tool : tools) {
            toolNames.add(tool.get("name").asText());
        }

        assertThat(toolNames)
                .as("Expected MCP tools from exported agents")
                .contains("bestDadJoke", "fibonacciNumbers", "sonicPiCode", "writeAndReviewStory");
    }

    @Test
    void shouldListPrompts() throws Exception {
        postJsonRpc("prompts/list", 20, MAPPER.createObjectNode());
        var response = waitForResponse(20);

        assertThat(response.has("result")).as("prompts/list has result").isTrue();
        var prompts = response.get("result").get("prompts");
        assertThat(prompts).as("prompts array").isNotNull();
        assertThat(prompts.isArray()).isTrue();
    }

    @Test
    void shouldHaveToolInputSchemas() throws Exception {
        postJsonRpc("tools/list", 30, MAPPER.createObjectNode());
        var response = waitForResponse(30);

        var tools = response.get("result").get("tools");
        for (JsonNode tool : tools) {
            var name = tool.get("name").asText();
            assertThat(tool.has("name")).as("tool has name").isTrue();
            assertThat(tool.has("inputSchema"))
                    .as("tool '%s' has inputSchema", name).isTrue();
        }
    }

    // --- Helper methods ---

    private static void postJsonRpc(String method, int id, JsonNode params) throws Exception {
        var node = MAPPER.createObjectNode();
        node.put("jsonrpc", "2.0");
        node.put("method", method);
        node.put("id", id);
        node.set("params", params);
        postMessage(node);
    }

    private static void postMessage(JsonNode message) throws Exception {
        var connection = (HttpURLConnection) URI.create(messageEndpoint).toURL().openConnection();
        connection.setRequestMethod("POST");
        connection.setRequestProperty("Content-Type", "application/json");
        connection.setDoOutput(true);
        connection.setConnectTimeout(5000);
        connection.setReadTimeout(5000);

        try (var out = connection.getOutputStream()) {
            out.write(MAPPER.writeValueAsBytes(message));
        }

        // Read response (202 Accepted expected; actual JSON-RPC response comes via SSE)
        connection.getResponseCode();
        connection.disconnect();
    }

    private static JsonNode waitForResponse(int expectedId) throws Exception {
        var deadline = System.currentTimeMillis() + 10_000;
        while (System.currentTimeMillis() < deadline) {
            var msg = sseMessages.poll(1, TimeUnit.SECONDS);
            if (msg != null && msg.has("id") && msg.get("id").asInt() == expectedId) {
                return msg;
            }
            // Put back messages that don't match (for other tests)
            if (msg != null) {
                sseMessages.put(msg);
            }
        }
        throw new AssertionError("Timed out waiting for JSON-RPC response with id=" + expectedId);
    }
}
