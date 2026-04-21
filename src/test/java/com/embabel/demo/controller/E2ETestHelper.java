package com.embabel.demo.controller;

import static org.assertj.core.api.Assertions.assertThat;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URI;
import java.nio.charset.StandardCharsets;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Shared HTTP helper methods for E2E integration tests.
 */
final class E2ETestHelper {

    private static final Logger LOG = LoggerFactory.getLogger(E2ETestHelper.class);
    private static final ObjectMapper MAPPER = new ObjectMapper();

    private E2ETestHelper() {}

    static ObjectMapper mapper() {
        return MAPPER;
    }

    static JsonNode getJson(String url) throws IOException {
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

    static JsonNode postTextForJson(String url, String body) throws IOException {
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

    static JsonNode postForJson(String url, int expectedStatus) throws IOException {
        LOG.info("POST {}", url);

        var connection = (HttpURLConnection) URI.create(url).toURL().openConnection();
        connection.setRequestMethod("POST");
        connection.setRequestProperty("Accept", "application/json");
        connection.setConnectTimeout(5000);
        connection.setReadTimeout(30_000);

        int status = connection.getResponseCode();
        LOG.info("Response status: {}", status);
        assertThat(status).as("HTTP status is %d", expectedStatus).isEqualTo(expectedStatus);

        try (var in = connection.getInputStream()) {
            var responseBody = new String(in.readAllBytes(), StandardCharsets.UTF_8);
            return MAPPER.readTree(responseBody);
        } finally {
            connection.disconnect();
        }
    }
}
