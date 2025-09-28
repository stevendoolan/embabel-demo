package com.embabel.demo;

import com.embabel.agent.api.common.autonomy.AgentInvocation;
import com.embabel.agent.core.AgentPlatform;
import com.embabel.agent.domain.io.UserInput;
import com.embabel.demo.model.ReviewedStory;
import com.embabel.demo.service.AnimalAIGenerator;
import org.springframework.shell.standard.ShellComponent;
import org.springframework.shell.standard.ShellMethod;

@ShellComponent
public record DemoShell(
        AnimalAIGenerator animalInventor,
        AgentPlatform agentPlatform) {

    @ShellMethod("Demo")
    String demo() {
        // Illustrate calling an agent programmatically,
        // as most often occurs in real applications.
        ReviewedStory reviewedStory = AgentInvocation
                .create(agentPlatform, ReviewedStory.class)
                .invoke(new UserInput("Tell me a story about caterpillars"));
        return reviewedStory.getContent();
    }

    @ShellMethod("Invent an animal")
    String animal() {
        return animalInventor.inventAnimal().toString();
    }
}
