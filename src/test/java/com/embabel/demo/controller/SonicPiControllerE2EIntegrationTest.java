package com.embabel.demo.controller;

import static org.assertj.core.api.Assertions.assertThat;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URI;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.Timeout;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * End-to-end integration test for the Sonic Pi controller.
 * Generates a Sonic Pi script via the async API and saves it to
 * {@code docs/sonic-pi/YYYYMMDD-HHmmss/}.
 *
 * <p>Requires the application to be running on localhost.
 * Port defaults to 48080 and can be overridden with {@code -DTEST_PORT=<port>}.
 */
@Tag("e2e")
@Timeout(600)
class SonicPiControllerE2EIntegrationTest {

    private static final Logger LOG = LoggerFactory.getLogger(SonicPiControllerE2EIntegrationTest.class);

    private static final String BASE_URL = "http://localhost:" + System.getProperty("TEST_PORT", "48080");

    private static Path outputDir;

    @BeforeAll
    static void setupOutputDir() throws IOException {
        var timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd-HHmmss"));
        outputDir = Path.of("docs/sonic-pi", timestamp);
        Files.createDirectories(outputDir);
        LOG.info("Sonic Pi scripts will be saved to: {}", outputDir);
    }

    @Test
    void shouldGenerateSonicPiScript() throws Exception {
        var prompt = "upbeat jazz tune";

        // Submit async job
        LOG.info("Calling POST /sonic-pi?prompt={} ...", prompt);
        var submitResponse = E2ETestHelper.postForJson(
                BASE_URL + "/sonic-pi?prompt=" + prompt.replace(" ", "+"), 202);
        assertThat(submitResponse.has("jobId")).as("response has 'jobId'").isTrue();
        var jobId = submitResponse.get("jobId").asText();
        LOG.info("Job submitted: {}", jobId);

        // Poll for completion using HTTP status code and X-Job-Status header
        String script = null;
        String jobStatus = "RUNNING";
        while ("RUNNING".equals(jobStatus)) {
            Thread.sleep(5000);
            var response = pollJob(BASE_URL + "/sonic-pi/" + jobId);
            jobStatus = response.status();
            LOG.info("Job {} status: {}", jobId, jobStatus);
            if ("COMPLETED".equals(jobStatus)) {
                script = response.body();
            }
        }

        assertThat(jobStatus).as("job completed successfully").isEqualTo("COMPLETED");
        assertThat(script).as("result script is not blank").isNotBlank();

        LOG.info("Sonic Pi script:\n\n{}\n\n", script);

        // Extract song title from first comment line and save to file
        var title = extractTitle(script);
        var fileName = title + ".rb";
        var outputFile = outputDir.resolve(fileName);
        Files.writeString(outputFile, script, StandardCharsets.UTF_8);
        LOG.info("Saved Sonic Pi script to: {}", outputFile);
    }

    /**
     * Extracts the song title from the first {@code # Title} comment line in the script.
     * Falls back to "Untitled" if no title comment is found.
     */
    static String extractTitle(String script) {
        for (var line : script.lines().toList()) {
            var trimmed = line.trim();
            if (trimmed.startsWith("#") && !trimmed.startsWith("#!")) {
                var title = trimmed.substring(1).trim();
                if (!title.isBlank()) {
                    // Sanitise for use as a filename
                    return title.replaceAll("[/\\\\:*?\"<>|]", "_");
                }
            }
            // Stop looking once we hit non-comment, non-blank lines
            if (!trimmed.isEmpty() && !trimmed.startsWith("#")) {
                break;
            }
        }
        return "Untitled";
    }

    // --- Helper methods ---

    private record JobPollResult(String status, String body) {}

    private static JobPollResult pollJob(String url) throws IOException {
        LOG.info("GET {}", url);

        var connection = (HttpURLConnection) URI.create(url).toURL().openConnection();
        connection.setRequestMethod("GET");
        connection.setConnectTimeout(5000);
        connection.setReadTimeout(120_000);

        try {
            int httpStatus = connection.getResponseCode();
            var jobStatus = connection.getHeaderField("X-Job-Status");
            LOG.info("Response status: {} (X-Job-Status: {})", httpStatus, jobStatus);

            if (httpStatus == 200) {
                var body = new String(connection.getInputStream().readAllBytes(), StandardCharsets.UTF_8);
                return new JobPollResult("COMPLETED", body);
            } else if (httpStatus == 202) {
                return new JobPollResult("RUNNING", null);
            } else {
                var errorStream = connection.getErrorStream();
                var body = errorStream != null
                        ? new String(errorStream.readAllBytes(), StandardCharsets.UTF_8)
                        : "Unknown error";
                throw new AssertionError("Job failed (HTTP " + httpStatus + "): " + body);
            }
        } finally {
            connection.disconnect();
        }
    }
}
