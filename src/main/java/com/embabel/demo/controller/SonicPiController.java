package com.embabel.demo.controller;

import com.embabel.agent.api.invocation.AgentInvocation;
import com.embabel.agent.core.AgentPlatform;
import com.embabel.agent.domain.io.UserInput;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ConcurrentHashMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class SonicPiController {

    private static final Logger LOG = LoggerFactory.getLogger(SonicPiController.class);

    private final AgentPlatform agentPlatform;
    private final ConcurrentHashMap<String, SonicPiJob> jobs = new ConcurrentHashMap<>();

    public SonicPiController(AgentPlatform agentPlatform) {
        this.agentPlatform = agentPlatform;
    }

    @PreAuthorize("hasRole('USER')")
    @PostMapping("/sonic-pi")
    public ResponseEntity<Map<String, String>> generateSonicPi(@RequestParam("prompt") String prompt) {
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

    @PreAuthorize("hasRole('USER')")
    @GetMapping("/sonic-pi/{jobId}")
    public ResponseEntity<SonicPiJob> getJobStatus(@PathVariable String jobId) {
        SonicPiJob job = jobs.get(jobId);
        if (job == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(job);
    }
}
