package com.embabel.demo.controller;

import com.embabel.agent.api.invocation.AgentInvocation;
import com.embabel.agent.core.AgentPlatform;
import com.embabel.agent.domain.io.UserInput;
import com.embabel.demo.model.story.Story;
import org.springframework.http.MediaType;
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
 * <a href="http://localhost:48080/story?about=Steven">http://localhost:48080/story?about=Steven</a>
 */
@RestController
public record StoryController(AgentPlatform agentPlatform) {

    @GetMapping(value = "/story", produces = MediaType.TEXT_PLAIN_VALUE)
    public String writeAStory(@RequestParam("about") String about) {
        return AgentInvocation.create(agentPlatform, Story.class)
                .invoke(new UserInput("Write a story about %s".formatted(about)))
                .text();
    }

    @PostMapping(value = "/story", produces = MediaType.TEXT_PLAIN_VALUE)
    public String writeAStoryFromPost(@RequestBody String about) {
        return AgentInvocation.create(agentPlatform, Story.class)
                .invoke(new UserInput(about))
                .text();
    }
}
