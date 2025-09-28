package com.embabel.demo.controller;

import com.embabel.agent.api.common.autonomy.AgentInvocation;
import com.embabel.agent.core.AgentPlatform;
import com.embabel.agent.domain.io.UserInput;
import com.embabel.demo.model.dadjoke.JokeAndRating;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * Controller to get the best dad joke about a given topic.
 * <p>
 * How to use:
 * 1. Comment out "embabel-agent-starter-shell" in pom.xml to disable the shell.
 * 2. Run the application.
 * 3. Open a browser and go to:
 * <a href="http://localhost:8080/best-dad-joke?topic=chicken">http://localhost:8080/best-dad-joke?topic=chicken</a>
 */
@RestController
public record BestDadJokeController(AgentPlatform agentPlatform) {

    @GetMapping("/best-dad-joke")
    public JokeAndRating getBestDadJoke(@RequestParam("topic") String topic) {
        return AgentInvocation.create(agentPlatform, JokeAndRating.class)
                .invoke(new UserInput("Tell me the best dad joke about %s".formatted(topic)));
    }
}
