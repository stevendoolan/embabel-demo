package com.embabel.demo.controller;

import static org.assertj.core.api.Assertions.assertThat;

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
 * Port defaults to 48080 and can be overridden with {@code -DTEST_PORT=<port>}.
 */
@Tag("e2e")
@Timeout(240)
class RestControllerE2EIntegrationTest {

    private static final Logger LOG = LoggerFactory.getLogger(RestControllerE2EIntegrationTest.class);

    private static final String BASE_URL = "http://localhost:" + System.getProperty("TEST_PORT", "48080");

    @Test
    void shouldGetDadJoke() throws Exception {
        LOG.info("Calling GET /dad-joke?topic=programming ...");
        var json = E2ETestHelper.getJson(BASE_URL + "/dad-joke?topic=programming");

        LOG.info("Response: {}", E2ETestHelper.mapper().writeValueAsString(json));

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

        LOG.info("Dad Joke:\n\n{}\n\n(score: {})", bestJoke.get("joke").asText(), rating.get("score").asDouble());

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
        var json = E2ETestHelper.getJson(BASE_URL + "/compute-fibonacci?iterations=10");

        LOG.info("Response: {}", E2ETestHelper.mapper().writeValueAsString(json));

        assertThat(json.has("fibonacciNumber")).as("response has 'fibonacciNumber'").isTrue();
        assertThat(json.get("fibonacciNumber").asLong()).as("fibonacci(10) = 55").isEqualTo(55L);

        assertThat(json.has("correct")).as("response has 'correct'").isTrue();
        assertThat(json.get("correct").asBoolean()).as("verification passed").isTrue();

        LOG.info("Fibonacci(10) = {}, correct = {}", json.get("fibonacciNumber"), json.get("correct").asBoolean());
    }

    @Test
    void shouldWriteAStory() throws Exception {
        LOG.info("Calling GET /story?about=a+brave+robot ...");
        var json = E2ETestHelper.getJson(BASE_URL + "/story?about=a+brave+robot");

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
        LOG.info("Calling POST /story with {} chars ...", story.length());
        var json = E2ETestHelper.postTextForJson(BASE_URL + "/story", story);

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
}
