package com.embabel.demo.controller;

import com.embabel.agent.api.invocation.AgentInvocation;
import com.embabel.agent.core.AgentPlatform;
import com.embabel.agent.domain.io.UserInput;
import com.embabel.demo.model.story.ReviewedStory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * Controller to write a story about a given topic.
 * <p>
 * How to use:
 * 1. Comment out "embabel-agent-starter-shell" in pom.xml to disable the shell.
 * 2. Run the application.
 * 3. Open a browser and go to:
 * <a href="http://localhost:8080/story?about=Steven">http://localhost:8080/story?about=Steven</a>
 */
@RestController
public record StoryWriterController(AgentPlatform agentPlatform) {

    @GetMapping("/story")
    public ReviewedStory writeAStory(@RequestParam("about") String about) {
        return AgentInvocation.create(agentPlatform, ReviewedStory.class)
                .invoke(new UserInput("Write a story about %s".formatted(about)));
    }

    @PostMapping("/story")
    public ReviewedStory writeAStoryFromPost(@RequestBody String about) {
        return AgentInvocation.create(agentPlatform, ReviewedStory.class)
                .invoke(new UserInput(about));
    }
}
