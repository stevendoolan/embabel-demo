package com.embabel.demo.agent;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import com.embabel.agent.api.invocation.AgentInvocation;
import com.embabel.agent.domain.io.UserInput;
import com.embabel.agent.test.integration.EmbabelMockitoIntegrationTest;
import com.embabel.demo.Application;
import com.embabel.demo.model.story.ReviewedStory;
import com.embabel.demo.model.story.Story;
import com.embabel.demo.model.story.StoryReview;
import com.embabel.demo.prompt.persona.StoryPersonas;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest(classes = Application.class)
class StoryAgentIntegrationTest extends EmbabelMockitoIntegrationTest {

    @BeforeAll
    static void setUp() {
        // Set shell configuration to non-interactive mode
        System.setProperty("embabel.agent.shell.interactive.enabled", "false");
    }

    @Test
    void shouldExecuteCompleteWorkflow() {
        var input = new UserInput("Write about artificial intelligence");

        var story = new Story("AI will transform our world...");
        var storyReview = new StoryReview(7, "Excellent exploration of AI themes.");
        var expectedBest = new ReviewedStory(story, storyReview, StoryPersonas.REVIEWER);

        whenCreateObject(prompt -> prompt.contains("Craft a short story"), Story.class)
                .thenReturn(story);

        whenCreateObject(prompt -> prompt.contains("You will be given a short story to review"), StoryReview.class)
                .thenReturn(storyReview);

        var invocation = AgentInvocation.create(agentPlatform, ReviewedStory.class);
        var result = invocation.invoke(input);

        assertNotNull(result);
        assertTrue(result.getContent().contains(story.text()),
                "Expected story content to be present: " + result.getContent());
        assertEquals(expectedBest.review(), result.review(),
                "Expected review to match: " + result);
    }

}
