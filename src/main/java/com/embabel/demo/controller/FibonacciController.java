package com.embabel.demo.controller;

import com.embabel.agent.api.common.autonomy.AgentInvocation;
import com.embabel.agent.core.AgentPlatform;
import com.embabel.demo.model.fibonacci.FibonacciRequest;
import com.embabel.demo.model.fibonacci.FibonacciResponseWithVerification;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public record FibonacciController(AgentPlatform agentPlatform) {

    /**
     * Compute Fibonacci number with verification.
     *
     * @param iterations The number of iterations. Must be non-negative. Starts from 0.
     * @return FibonacciResponseWithVerification containing the fibonacciNumber and verification status
     */
    @GetMapping("/compute-fibonacci")
    public FibonacciResponseWithVerification computeFibonacci(@RequestParam("iterations") int iterations) {
        return AgentInvocation.create(agentPlatform, FibonacciResponseWithVerification.class)
                .invoke(new FibonacciRequest(iterations));
    }

}
