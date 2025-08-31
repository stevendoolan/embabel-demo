/*
 * Copyright 2024-2025 Embabel Software, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.embabel.demo.agent;

import com.embabel.agent.api.annotation.AchievesGoal;
import com.embabel.agent.api.annotation.Action;
import com.embabel.agent.api.annotation.Agent;
import com.embabel.agent.api.annotation.Export;
import com.embabel.agent.api.common.OperationContext;
import com.embabel.agent.domain.io.UserInput;
import com.embabel.common.ai.model.LlmOptions;
import com.embabel.demo.model.ReviewedStory;
import com.embabel.demo.model.Story;
import com.embabel.demo.persona.Personas;
import java.util.Map;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Profile;

@Agent(description = "Generate a story based on user input and review it")
@Profile("!test")
public class WriteAndReviewAgent {

    private final int storyWordCount;
    private final int reviewWordCount;

    WriteAndReviewAgent(
            @Value("${storyWordCount:100}") int storyWordCount,
            @Value("${reviewWordCount:100}") int reviewWordCount
    ) {
        this.storyWordCount = storyWordCount;
        this.reviewWordCount = reviewWordCount;
    }

    @AchievesGoal(
            description = "The story has been crafted and reviewed by a book reviewer",
            export = @Export(remote = true, name = "writeAndReviewStory"))
    @Action
    ReviewedStory reviewStory(UserInput userInput, Story story, OperationContext context) {
        var review = context
                .ai()
                .withAutoLlm()
                .withPromptContributor(Personas.REVIEWER)
                .withTemplate("prompt-templates/review-story-template.jinja")
                .createObject(String.class,
                        Map.of(
                                "story", story.text(),
                                "userInput", userInput.getContent()
                        ));
//                .generateText(String.format("""
//                                You will be given a short story to review.
//                                Review it in %d words or less.
//                                Consider whether or not the story is engaging, imaginative, and well-written.
//                                Also consider whether the story is appropriate given the original user input.
//
//                                # Story
//                                %s
//
//                                # User input that inspired the story
//                                %s
//                                """,
//                        reviewWordCount,
//                        story.text(),
//                        userInput.getContent()
//                ).trim());

        return new ReviewedStory(
                story,
                review,
                Personas.REVIEWER
        );
    }

    @Action
    Story craftStory(UserInput userInput, OperationContext context) {
        return context.ai()
                // Higher temperature for more creative output
                .withLlm(LlmOptions.withAutoLlm().withTemperature(.7))
                .withPromptContributor(Personas.WRITER)
                .createObject(String.format("""
                                Craft a short story in %d words or less.
                                The story should be engaging and imaginative.
                                Use the user's input as inspiration if possible.
                                If the user has provided a name, include it in the story.
                                
                                # User input
                                %s
                                """,
                        storyWordCount,
                        userInput.getContent()
                ).trim(), Story.class);
    }
}