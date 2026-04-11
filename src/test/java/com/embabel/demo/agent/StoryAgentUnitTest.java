package com.embabel.demo.agent;

import static org.junit.jupiter.api.Assertions.assertTrue;

import com.embabel.agent.domain.io.UserInput;
import com.embabel.agent.test.unit.FakeOperationContext;
import com.embabel.agent.test.unit.FakePromptRunner;
import com.embabel.demo.model.story.Stories;
import com.embabel.demo.model.story.Story;
import com.embabel.demo.model.story.StoryReview;
import java.time.Instant;
import java.util.List;
import org.junit.jupiter.api.Test;

class StoryAgentUnitTest {

    @Test
    void testCraftStories() {
        var context = FakeOperationContext.create();
        var promptRunner = (FakePromptRunner) context.promptRunner();
        context.expectResponse(new Story("One upon a time Sir Galahad . . "));
        context.expectResponse(new Story("Sir Galahad rode into the sunset . . "));

        var agent = new StoryAgent(2, 200, 400);
        agent.craftStories(new UserInput("Tell me a story about a brave knight", Instant.now()), context);

        String prompt = promptRunner.getLlmInvocations().getFirst().getMessages().getFirst().getContent();
        assertTrue(prompt.contains("knight"), "Expected prompt to contain 'knight'");
    }

    @Test
    void testReviewStories() {
        var agent = new StoryAgent(2, 200, 400);
        var userInput = new UserInput("Tell me a story about a brave knight", Instant.now());
        var stories = new Stories(List.of(new Story("Once upon a time, Sir Galahad...")));
        var context = FakeOperationContext.create();
        context.expectResponse(new StoryReview(7, "A thrilling tale of bravery and adventure!"));
        agent.reviewStories(userInput, stories, context);
        var prompt = context.getLlmInvocations().getFirst().getMessages().getFirst().getContent();
        assertTrue(prompt.contains("knight"), "Expected prompt to contain 'knight'");
        assertTrue(prompt.contains("review"), "Expected prompt to contain 'review'");
    }

}
