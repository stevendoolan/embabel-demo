package com.embabel.demo.controller;

import static org.assertj.core.api.Assertions.assertThat;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URI;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.Timeout;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * End-to-end integration test for the REST controllers.
 * Requires the application to be running on localhost.
 * Port defaults to 48080 (Docker) and can be overridden with {@code -DTEST_PORT=8080}.
 */
@Tag("e2e")
@Timeout(240)
class RestControllerIntegrationTest {

    private static final Logger LOG = LoggerFactory.getLogger(RestControllerIntegrationTest.class);

    private static final String BASE_URL = "http://localhost:" + System.getProperty("TEST_PORT", "48080");
    private static final ObjectMapper MAPPER = new ObjectMapper();

    @Test
    void shouldGetBestDadJoke() throws Exception {
        LOG.info("Calling GET /best-dad-joke?topic=programming ...");
        var json = getJson(BASE_URL + "/best-dad-joke?topic=programming");

        LOG.info("Response: {}", MAPPER.writeValueAsString(json));

        // Verify best joke
        assertThat(json.has("bestJoke")).as("response has 'bestJoke' field").isTrue();
        var bestJoke = json.get("bestJoke");
        assertThat(bestJoke.has("joke")).as("bestJoke has 'joke' field").isTrue();
        assertThat(bestJoke.get("joke").asText()).as("joke is not blank").isNotBlank();

        assertThat(bestJoke.has("rating")).as("bestJoke has 'rating' field").isTrue();
        var rating = bestJoke.get("rating");
        assertThat(rating.has("score")).as("rating has 'score' field").isTrue();
        assertThat(rating.get("score").asDouble()).as("score is between 0 and 10")
                .isBetween(0.0, 10.0);

        // Verify all jokes and ratings
        assertThat(json.has("otherJokes")).as("response has 'otherJokes' field").isTrue();
        var allJokes = json.get("otherJokes");
        assertThat(allJokes.isArray()).as("otherJokes is an array").isTrue();
        assertThat(allJokes.size()).as("otherJokes has at least 2 entries").isGreaterThanOrEqualTo(2);

        for (var jokeEntry : allJokes) {
            assertThat(jokeEntry.has("joke")).as("each entry has 'joke'").isTrue();
            assertThat(jokeEntry.get("joke").asText()).as("joke is not blank").isNotBlank();
            assertThat(jokeEntry.has("rating")).as("each entry has 'rating'").isTrue();
            assertThat(jokeEntry.get("rating").has("score")).as("each rating has 'score'").isTrue();
        }

        LOG.info("Best Dad Joke:\n\n{}\n\n(score: {})", bestJoke.get("joke").asText(), rating.get("score").asDouble());

        var sb = new StringBuilder("Other jokes:\n");
        for (var jokeEntry : allJokes) {
            sb.append("  [%.1f] %s%n".formatted(
                    jokeEntry.get("rating").get("score").asDouble(),
                    jokeEntry.get("joke").asText()));
        }
        LOG.info(sb.toString());
    }

    @Test
    void shouldComputeFibonacci() throws Exception {
        LOG.info("Calling GET /compute-fibonacci?iterations=10 ...");
        var json = getJson(BASE_URL + "/compute-fibonacci?iterations=10");

        LOG.info("Response: {}", MAPPER.writeValueAsString(json));

        assertThat(json.has("fibonacciNumber")).as("response has 'fibonacciNumber'").isTrue();
        assertThat(json.get("fibonacciNumber").asLong()).as("fibonacci(10) = 55").isEqualTo(55L);

        assertThat(json.has("correct")).as("response has 'correct'").isTrue();
        assertThat(json.get("correct").asBoolean()).as("verification passed").isTrue();

        LOG.info("Fibonacci(10) = {}, correct = {}", json.get("fibonacciNumber"), json.get("correct").asBoolean());
    }

    @Test
    void shouldWriteAStory() throws Exception {
        LOG.info("Calling GET /write-a-story?about=a+brave+robot ...");
        var json = getJson(BASE_URL + "/write-a-story?about=a+brave+robot");

        LOG.debug("Response:\n\n{}\n\n", json);

        assertThat(json.has("story")).as("response has 'story'").isTrue();
        var story = json.get("story");
        assertThat(story.has("text")).as("story has 'text'").isTrue();
        assertThat(story.get("text").asText()).as("story text is not blank").isNotBlank();

        LOG.info("Story text:\n\n{}\n\n", story.get("text").asText());

        assertThat(json.has("review")).as("response has 'review'").isTrue();
        var review = json.get("review");
        assertThat(review.has("rating")).as("review has 'rating'").isTrue();
        assertThat(review.get("rating").asInt()).as("review rating is between 1 and 10").isBetween(1, 10);
        assertThat(review.has("explanation")).as("review has 'explanation'").isTrue();
        assertThat(review.get("explanation").asText()).as("review explanation is not blank").isNotBlank();

        assertThat(json.has("reviewer")).as("response has 'reviewer'").isTrue();

        LOG.info("Review: Rating: {}/10\nExplanation:\n\n{}\n\n",
                review.get("rating").asInt(), review.get("explanation").asText());
    }

    @Test
    void shouldWriteAStoryFromPost() throws Exception {
        var story = Files.readString(Path.of("src/test/resources/Incident Chat.md"), StandardCharsets.UTF_8);
        LOG.info("Calling POST /write-a-story with {} chars ...", story.length());
        var json = postTextForJson(BASE_URL + "/write-a-story", story);

        LOG.debug("Response:\n\n{}\n\n", json);

        assertThat(json.has("story")).as("response has 'story'").isTrue();
        var storyNode = json.get("story");
        assertThat(storyNode.has("text")).as("story has 'text'").isTrue();
        assertThat(storyNode.get("text").asText()).as("story text is not blank").isNotBlank();

        LOG.info("Story text:\n\n{}\n\n", storyNode.get("text").asText());

        assertThat(json.has("review")).as("response has 'review'").isTrue();
        var review = json.get("review");
        assertThat(review.has("rating")).as("review has 'rating'").isTrue();
        assertThat(review.get("rating").asInt()).as("review rating is between 1 and 10").isBetween(1, 10);
        assertThat(review.has("explanation")).as("review has 'explanation'").isTrue();
        assertThat(review.get("explanation").asText()).as("review explanation is not blank").isNotBlank();

        assertThat(json.has("reviewer")).as("response has 'reviewer'").isTrue();

        LOG.info("Review: Rating: {}/10\nExplanation:\n\n{}\n\n",
                review.get("rating").asInt(), review.get("explanation").asText());
    }

    @Test
    @Timeout(600)
    void shouldGenerateSonicPiScript() throws Exception {
        // Submit async job
        LOG.info("Calling POST /sonic-pi?prompt=upbeat+jazz+tune ...");
        var submitResponse = postForJson(BASE_URL + "/sonic-pi?prompt=upbeat+jazz+tune");
        assertThat(submitResponse.has("jobId")).as("response has 'jobId'").isTrue();
        var jobId = submitResponse.get("jobId").asText();
        LOG.info("Job submitted: {}", jobId);

        // Poll for completion
        JsonNode json = null;
        String status = "RUNNING";
        while ("RUNNING".equals(status)) {
            Thread.sleep(5000);
            json = getJson(BASE_URL + "/sonic-pi/" + jobId);
            status = json.get("status").asText();
            LOG.info("Job {} status: {}", jobId, status);
        }

        assertThat(status).as("job completed successfully").isEqualTo("COMPLETED");
        LOG.info("Response: {}", MAPPER.writeValueAsString(json));

        // Verify result is a non-blank script string
        assertThat(json.has("result")).as("response has 'result'").isTrue();
        var result = json.get("result").asText();
        assertThat(result).as("result script is not blank").isNotBlank();

        LOG.info("Sonic Pi script:\n\n{}\n\n", result);
    }

    // --- Helper methods ---

    private static JsonNode postForJson(String url) throws IOException {
        LOG.info("POST {}", url);

        var connection = (HttpURLConnection) URI.create(url).toURL().openConnection();
        connection.setRequestMethod("POST");
        connection.setRequestProperty("Accept", "application/json");
        connection.setConnectTimeout(5000);
        connection.setReadTimeout(30_000);

        int status = connection.getResponseCode();
        LOG.info("Response status: {}", status);
        assertThat(status).as("HTTP status is 202 Accepted").isEqualTo(202);

        try (var in = connection.getInputStream()) {
            var body = new String(in.readAllBytes(), StandardCharsets.UTF_8);
            return MAPPER.readTree(body);
        } finally {
            connection.disconnect();
        }
    }

    private static JsonNode postTextForJson(String url, String body) throws IOException {
        LOG.info("POST {} ({} chars)", url, body.length());

        var connection = (HttpURLConnection) URI.create(url).toURL().openConnection();
        connection.setRequestMethod("POST");
        connection.setRequestProperty("Content-Type", "text/plain; charset=UTF-8");
        connection.setRequestProperty("Accept", "application/json");
        connection.setDoOutput(true);
        connection.setConnectTimeout(5000);
        connection.setReadTimeout(120_000);

        try (OutputStream os = connection.getOutputStream()) {
            os.write(body.getBytes(StandardCharsets.UTF_8));
        }

        int status = connection.getResponseCode();
        LOG.info("Response status: {}", status);
        assertThat(status).as("HTTP status is 200 OK").isEqualTo(200);

        try (var in = connection.getInputStream()) {
            var responseBody = new String(in.readAllBytes(), StandardCharsets.UTF_8);
            return MAPPER.readTree(responseBody);
        } finally {
            connection.disconnect();
        }
    }

    private static JsonNode getJson(String url) throws IOException {
        LOG.info("GET {}", url);

        var connection = (HttpURLConnection) URI.create(url).toURL().openConnection();
        connection.setRequestMethod("GET");
        connection.setRequestProperty("Accept", "application/json");
        connection.setConnectTimeout(5000);
        connection.setReadTimeout(120_000);

        int status = connection.getResponseCode();
        LOG.info("Response status: {}", status);
        assertThat(status).as("HTTP status is 200 OK").isEqualTo(200);

        try (var in = connection.getInputStream()) {
            var body = new String(in.readAllBytes(), StandardCharsets.UTF_8);
            return MAPPER.readTree(body);
        } finally {
            connection.disconnect();
        }
    }
}
