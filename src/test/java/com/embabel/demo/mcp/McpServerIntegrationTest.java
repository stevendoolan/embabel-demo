package com.embabel.demo.mcp;

import static org.assertj.core.api.Assertions.assertThat;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
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
import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.Timeout;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Integration test for the MCP server SSE endpoint.
 * Requires the application to be running on localhost.
 * Port defaults to 48080 (Docker) and can be overridden with {@code -DTEST_PORT=8080}.
 */
@Tag("e2e")
@Timeout(30)
class McpServerIntegrationTest {

    private static final Logger LOG = LoggerFactory.getLogger(McpServerIntegrationTest.class);

    private static final String BASE_URL = "http://localhost:" + System.getProperty("TEST_PORT", "48080");
    private static final String SSE_URL = BASE_URL + "/sse";
    private static final ObjectMapper MAPPER = new ObjectMapper();

    private static String messageEndpoint;
    private static BlockingQueue<JsonNode> sseMessages;
    private static Thread sseThread;

    @BeforeAll
    static void connectAndInitialize() throws Exception {
        sseMessages = new LinkedBlockingQueue<>();

        LOG.info("Connecting to MCP SSE endpoint: {}", SSE_URL);

        // Connect to SSE endpoint in a background thread
        var endpointReady = new LinkedBlockingQueue<String>();

        sseThread = Thread.ofVirtual().start(() -> {
            try {
                var connection = (HttpURLConnection) URI.create(SSE_URL).toURL().openConnection();
                connection.setRequestProperty("Accept", "text/event-stream");
                connection.setConnectTimeout(5000);
                connection.setReadTimeout(0); // no timeout, keep stream open

                LOG.info("SSE connection established, reading events...");

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
                                    data = BASE_URL + data;
                                }
                                LOG.info("Received SSE endpoint event: {}", data);
                                endpointReady.put(data);
                            } else if ("message".equals(eventType)) {
                                var parsed = MAPPER.readTree(data);
                                LOG.info("Received SSE message: {}", MAPPER.writeValueAsString(parsed));
                                sseMessages.put(parsed);
                            }
                            eventType = null;
                        }
                    }
                }
            } catch (Exception e) {
                if (!Thread.currentThread().isInterrupted()) {
                    LOG.error("SSE connection error", e);
                }
            }
        });

        // Wait for the endpoint event
        messageEndpoint = endpointReady.poll(10, TimeUnit.SECONDS);
        assertThat(messageEndpoint).as("SSE endpoint event").isNotNull();
        LOG.info("MCP message endpoint discovered: {}", messageEndpoint);

        // Initialize the MCP session
        LOG.info("Sending initialize request...");
        var initParams = MAPPER.createObjectNode();
        initParams.put("protocolVersion", "2024-11-05");
        initParams.set("capabilities", MAPPER.createObjectNode());
        initParams.set("clientInfo",
                MAPPER.createObjectNode().put("name", "test-client").put("version", "1.0.0"));

        postJsonRpc("initialize", 1, initParams);
        var initResponse = waitForResponse(1);
        assertThat(initResponse.has("result")).as("initialize response").isTrue();
        LOG.info("MCP session initialized. Server info: {}",
                initResponse.get("result").has("serverInfo")
                        ? MAPPER.writeValueAsString(initResponse.get("result").get("serverInfo"))
                        : "N/A");

        // Send initialized notification
        LOG.info("Sending initialized notification...");
        var notification = MAPPER.createObjectNode()
                .put("jsonrpc", "2.0")
                .put("method", "notifications/initialized");
        postMessage(notification);
        LOG.info("MCP handshake complete");
    }

    @AfterAll
    static void disconnect() {
        LOG.info("Disconnecting SSE stream");
        if (sseThread != null) {
            sseThread.interrupt();
        }
    }

    @Test
    void shouldRespondToPing() throws Exception {
        LOG.info("Sending ping...");
        postJsonRpc("ping", 60, MAPPER.createObjectNode());
        var response = waitForResponse(60);

        assertThat(response.has("result")).as("ping has result").isTrue();
        LOG.info("Ping response: {}", MAPPER.writeValueAsString(response.get("result")));
    }

    @Test
    void shouldListExpectedTools() throws Exception {
        LOG.info("Requesting tools/list...");
        postJsonRpc("tools/list", 10, MAPPER.createObjectNode());
        var response = waitForResponse(10);

        assertThat(response.has("result")).as("tools/list has result").isTrue();
        var tools = response.get("result").get("tools");
        assertThat(tools.isArray()).isTrue();

        List<String> toolNames = new ArrayList<>();
        for (JsonNode tool : tools) {
            toolNames.add(tool.get("name").asText());
        }

        LOG.info("Available tools ({}): {}", toolNames.size(), toolNames);

        assertThat(toolNames)
                .as("Expected MCP tools from exported agents")
                .contains("dadJoke", "fibonacciNumbers", "writeAndReviewStory");
    }

    @Test
    void shouldListPrompts() throws Exception {
        LOG.info("Requesting prompts/list...");
        postJsonRpc("prompts/list", 20, MAPPER.createObjectNode());
        var response = waitForResponse(20);

        assertThat(response.has("result")).as("prompts/list has result").isTrue();
        var prompts = response.get("result").get("prompts");
        assertThat(prompts).as("prompts array").isNotNull();
        assertThat(prompts.isArray()).isTrue();

        List<String> promptNames = new ArrayList<>();
        for (JsonNode prompt : prompts) {
            promptNames.add(prompt.get("name").asText());
        }

        LOG.info("Available prompts ({}): {}", promptNames.size(), promptNames);
    }

    @Test
    void shouldHaveToolInputSchemas() throws Exception {
        LOG.info("Requesting tools/list to verify input schemas...");
        postJsonRpc("tools/list", 30, MAPPER.createObjectNode());
        var response = waitForResponse(30);

        var tools = response.get("result").get("tools");
        for (JsonNode tool : tools) {
            var name = tool.get("name").asText();
            assertThat(tool.has("name")).as("tool has name").isTrue();
            assertThat(tool.has("inputSchema"))
                    .as("tool '%s' has inputSchema", name).isTrue();
            LOG.info("Tool '{}' inputSchema: {}", name, MAPPER.writeValueAsString(tool.get("inputSchema")));
        }
    }

    @Test
    @Timeout(120)
    void shouldInvokeDadJokeTool() throws Exception {
        LOG.info("Invoking tools/call for dadJoke...");
        var params = MAPPER.createObjectNode();
        params.put("name", "dadJoke");
        params.set("arguments", MAPPER.createObjectNode().put("content", "programming"));

        postJsonRpc("tools/call", 70, params);
        var response = waitForResponse(70, 120_000);

        assertThat(response.has("result")).as("tools/call has result").isTrue();
        var result = response.get("result");
        LOG.info("dadJoke result: {}", MAPPER.writeValueAsString(result));

        assertThat(result.has("content")).as("result has content").isTrue();
        var content = result.get("content");
        assertThat(content.isArray()).as("content is array").isTrue();
        assertThat(content.size()).as("content is not empty").isGreaterThan(0);

        var firstContent = content.get(0);
        assertThat(firstContent.get("type").asText()).as("content type is text").isEqualTo("text");

        var text = firstContent.get("text").asText();
        LOG.info("dadJoke response text: {}", text);

        // Response is a Java record toString(): JokeAndRating[joke=..., rating=Rating[score=N.N]]
        assertThat(text).as("response contains joke").contains("joke=");
        assertThat(text).as("response contains rating").contains("rating=");
        assertThat(text).as("response contains score").containsPattern("score=\\d");

        LOG.info("Dad joke response: {}", text);
    }

    @Test
    @Timeout(120)
    void shouldInvokeWriteAndReviewStoryTool() throws Exception {
        LOG.info("Invoking tools/call for writeAndReviewStory...");
        var params = MAPPER.createObjectNode();
        params.put("name", "writeAndReviewStory");
        params.set("arguments", MAPPER.createObjectNode().put("content", "a brave developer who fixed a production outage"));

        postJsonRpc("tools/call", 80, params);
        var response = waitForResponse(80, 120_000);

        assertThat(response.has("result")).as("tools/call has result").isTrue();
        var result = response.get("result");
        LOG.info("writeAndReviewStory result:\n\n{}\n\n", MAPPER.writeValueAsString(result));

        assertThat(result.has("content")).as("result has content").isTrue();
        var content = result.get("content");
        assertThat(content.isArray()).as("content is array").isTrue();
        assertThat(content.size()).as("content is not empty").isGreaterThan(0);

        var firstContent = content.get(0);
        assertThat(firstContent.get("type").asText()).as("content type is text").isEqualTo("text");

        var text = firstContent.get("text").asText();
        LOG.info("writeAndReviewStory response text:\n\n{}\n\n", text);

        assertThat(text).as("response contains story section").contains("# Story");
        assertThat(text).as("response contains review section").contains("# Review");
        assertThat(text).as("response contains rating").containsPattern("Rating: \\d+/10");
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
        LOG.info("POST {} -> {}", messageEndpoint, MAPPER.writeValueAsString(message));

        var connection = (HttpURLConnection) URI.create(messageEndpoint).toURL().openConnection();
        connection.setRequestMethod("POST");
        connection.setRequestProperty("Content-Type", "application/json");
        connection.setDoOutput(true);
        connection.setConnectTimeout(5000);
        connection.setReadTimeout(120_000);

        try (var out = connection.getOutputStream()) {
            out.write(MAPPER.writeValueAsBytes(message));
        }

        // Read response (202 Accepted expected; actual JSON-RPC response comes via SSE)
        int status = connection.getResponseCode();
        LOG.info("POST response status: {}", status);
        connection.disconnect();
    }

    private static JsonNode waitForResponse(int expectedId) throws Exception {
        return waitForResponse(expectedId, 10_000);
    }

    private static JsonNode waitForResponse(int expectedId, long timeoutMillis) throws Exception {
        LOG.info("Waiting for JSON-RPC response with id={} (timeout={}ms)...", expectedId, timeoutMillis);
        var deadline = System.currentTimeMillis() + timeoutMillis;
        while (System.currentTimeMillis() < deadline) {
            var msg = sseMessages.poll(1, TimeUnit.SECONDS);
            if (msg != null && msg.has("id") && msg.get("id").asInt() == expectedId) {
                LOG.info("Received response for id={}: {}", expectedId, MAPPER.writeValueAsString(msg));
                return msg;
            }
            // Put back messages that don't match (for other tests)
            if (msg != null) {
                LOG.debug("Received message with id={}, re-queuing (waiting for id={})",
                        msg.has("id") ? msg.get("id").asInt() : "none", expectedId);
                sseMessages.put(msg);
            }
        }
        throw new AssertionError("Timed out waiting for JSON-RPC response with id=" + expectedId);
    }
}
