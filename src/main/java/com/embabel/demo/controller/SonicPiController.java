package com.embabel.demo.controller;

import com.embabel.agent.api.invocation.AgentInvocation;
import com.embabel.agent.core.AgentPlatform;
import com.embabel.agent.domain.io.UserInput;
import com.embabel.demo.service.SonicPiExampleIndexer;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ConcurrentHashMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * REST controller that exposes asynchronous Sonic Pi music generation. {@code POST /sonic-pi}
 * accepts a free-text prompt and returns a job ID immediately; the agent pipeline runs in the
 * background. {@code GET /sonic-pi/{jobId}} polls for the result (running, completed, or failed).
 *
 * <p>Returns HTTP 503 (Service Unavailable) if the example store has not finished indexing.
 */
@RestController
public class SonicPiController {

    private static final Logger LOG = LoggerFactory.getLogger(SonicPiController.class);
    private static final String NOT_READY_MESSAGE = "Sonic Pi example store is still loading. Please try again shortly.";

    private final AgentPlatform agentPlatform;
    private final SonicPiExampleIndexer indexer;
    private final ConcurrentHashMap<String, SonicPiJob> jobs = new ConcurrentHashMap<>();

    public SonicPiController(AgentPlatform agentPlatform, SonicPiExampleIndexer indexer) {
        this.agentPlatform = agentPlatform;
        this.indexer = indexer;
    }

    @PostMapping("/sonic-pi")
    public ResponseEntity<Map<String, String>> generateSonicPi(@RequestParam("prompt") String prompt) {
        if (!indexer.isReady()) {
            return ResponseEntity.status(HttpStatus.SERVICE_UNAVAILABLE)
                    .body(Map.of("error", NOT_READY_MESSAGE));
        }

        String jobId = UUID.randomUUID().toString();
        jobs.put(jobId, SonicPiJob.running(jobId));

        CompletableFuture.supplyAsync(() ->
                AgentInvocation.create(agentPlatform, String.class)
                        .invoke(new UserInput(prompt))
        ).whenComplete((result, ex) -> {
            if (ex != null) {
                LOG.error("Sonic Pi job {} failed", jobId, ex);
                jobs.put(jobId, SonicPiJob.failed(jobId, ex.getMessage()));
            } else {
                LOG.info("Sonic Pi job {} completed", jobId);
                jobs.put(jobId, SonicPiJob.completed(jobId, result));
            }
        });

        return ResponseEntity.status(HttpStatus.ACCEPTED)
                .body(Map.of("jobId", jobId));
    }

    @GetMapping("/sonic-pi/{jobId}")
    public ResponseEntity<String> getJobStatus(@PathVariable String jobId) {
        if (!indexer.isReady()) {
            return ResponseEntity.status(HttpStatus.SERVICE_UNAVAILABLE)
                    .body(NOT_READY_MESSAGE);
        }

        SonicPiJob job = jobs.get(jobId);
        if (job == null) {
            return ResponseEntity.notFound().build();
        }

        HttpHeaders headers = new HttpHeaders();
        headers.set("X-Job-Id", job.jobId());
        headers.set("X-Job-Status", job.status().name());

        return switch (job.status()) {
            case RUNNING -> ResponseEntity.status(HttpStatus.ACCEPTED)
                    .headers(headers)
                    .body("Job is still running");
            case COMPLETED -> ResponseEntity.ok()
                    .headers(headers)
                    .body(job.result());
            case FAILED -> ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .headers(headers)
                    .body(job.error());
        };
    }
}
