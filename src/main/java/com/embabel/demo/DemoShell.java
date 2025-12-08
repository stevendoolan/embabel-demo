package com.embabel.demo;

import com.embabel.agent.api.common.autonomy.AgentInvocation;
import com.embabel.agent.core.AgentPlatform;
import com.embabel.agent.domain.io.UserInput;
import com.embabel.demo.model.dadjoke.JokeAndRating;
import com.embabel.demo.model.fibonacci.FibonacciResponseWithVerification;
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

    @ShellMethod("Compute Fibonacci")
    String fibonacci() {
        var fibonacciResponseWithVerification = AgentInvocation
                .create(agentPlatform, FibonacciResponseWithVerification.class)
                .invoke(new UserInput("What is the 10th Fibonacci number?"));

        if (fibonacciResponseWithVerification.correct()) {
            return "The 10th Fibonacci number is " + fibonacciResponseWithVerification.fibonacciNumber() + ".";
        } else {
            return "The 10th Fibonacci number was computed incorrectly as %s. The correct Fibonacci number is %s."
                    .formatted(
                            fibonacciResponseWithVerification.fibonacciNumber(),
                            fibonacciResponseWithVerification.fibonacciResponseWithTool().fibonacciNumber());
        }
    }

    @ShellMethod("Invent an animal")
    String animal() {
        return animalInventor.inventAnimal().toString();
    }
}
