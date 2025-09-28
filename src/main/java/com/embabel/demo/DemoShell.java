package com.embabel.demo;

import com.embabel.agent.api.common.autonomy.AgentInvocation;
import com.embabel.agent.core.AgentPlatform;
import com.embabel.agent.domain.io.UserInput;
import com.embabel.demo.model.dadjoke.JokeAndRating;
import com.embabel.demo.model.story.ReviewedStory;
import com.embabel.demo.service.AnimalAIGenerator;
import org.springframework.shell.standard.ShellComponent;
import org.springframework.shell.standard.ShellMethod;

@ShellComponent
public record DemoShell(
        AnimalAIGenerator animalInventor,
        AgentPlatform agentPlatform) {

    @ShellMethod("Demo")
    String demo() {
        return "Run these commands: `story`, `joke`, `animal`, `x \"Tell me a story about chickens\"`, `x \"Tell me a joke about cats\"`";
    }

    @ShellMethod("Story Demo")
    String story() {
        ReviewedStory reviewedStory = AgentInvocation
                .create(agentPlatform, ReviewedStory.class)
                .invoke(new UserInput(
                        "Tell me a story about a Programmer named Steven."));
        return reviewedStory.getContent();
    }

    @ShellMethod("Best Dad Joke Demo")
    String joke() {
        return AgentInvocation
                .create(agentPlatform, JokeAndRating.class)
                .invoke(new UserInput("Programmer"))
                .joke();
    }

    @ShellMethod("Invent an animal")
    String animal() {
        return animalInventor.inventAnimal().toString();
    }
}
