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
import org.junit.jupiter.api.Timeout;
import org.junit.jupiter.api.parallel.Execution;
import org.junit.jupiter.api.parallel.ExecutionMode;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * End-to-end integration test for the Sonic Pi controller.
 * Generates Sonic Pi scripts via the async API and saves them to
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

        var latestLink = Path.of("docs/sonic-pi", "latest");
        Files.deleteIfExists(latestLink);
        Files.createSymbolicLink(latestLink, Path.of(timestamp));
        LOG.info("Updated symlink {} -> {}", latestLink, timestamp);
    }

    @ParameterizedTest(name = "{0}")
    @ValueSource(strings = {
            "Electronic Classical Fusion",
            "Electronic Dreams",
            "Feed the Birds EDM Remix",
            "Java User Group Dance Anthem",
            "Smooth Croon"
    })
    void shouldGenerateSonicPiScript(String prompt) throws Exception {
        var encodedPrompt = prompt.replace(" ", "+");
        var url = BASE_URL + "/sonic-pi?prompt=" + encodedPrompt;

        // Submit async job, retrying on 503 while the indexer is still loading
        var jobId = submitJobWithRetry(url);
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

        // Save using the prompt name as the filename
        var outputFile = outputDir.resolve(prompt + ".rb");
        Files.writeString(outputFile, script, StandardCharsets.UTF_8);
        LOG.info("Saved Sonic Pi script to: {}", outputFile);
    }

    // --- Helper methods ---

    /**
     * POSTs to the given URL, retrying every 5 seconds (up to 5 minutes) if the server returns
     * 503 because the example indexer is still loading. Returns the job ID on success.
     */
    private static String submitJobWithRetry(String url) throws Exception {
        int maxAttempts = 60;
        for (int attempt = 1; attempt <= maxAttempts; attempt++) {
            LOG.info("POST {} (attempt {})", url, attempt);

            var connection = (HttpURLConnection) URI.create(url).toURL().openConnection();
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Accept", "application/json");
            connection.setConnectTimeout(5000);
            connection.setReadTimeout(30_000);

            try {
                int status = connection.getResponseCode();
                if (status == 202) {
                    try (var in = connection.getInputStream()) {
                        var body = new String(in.readAllBytes(), StandardCharsets.UTF_8);
                        var json = E2ETestHelper.mapper().readTree(body);
                        assertThat(json.has("jobId")).as("response has 'jobId'").isTrue();
                        return json.get("jobId").asText();
                    }
                }
                if (status == 503) {
                    LOG.info("Indexer not ready (attempt {}/{}) — retrying in 5s...", attempt, maxAttempts);
                } else {
                    throw new AssertionError("Unexpected HTTP status " + status + " from POST " + url);
                }
            } finally {
                connection.disconnect();
            }

            Thread.sleep(5000);
        }

        throw new AssertionError("Sonic Pi indexer did not become ready within 5 minutes");
    }

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
