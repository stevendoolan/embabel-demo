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
import com.embabel.demo.model.story.ReviewedStories;
import com.embabel.demo.model.story.ReviewedStory;
import com.embabel.demo.model.story.Stories;
import com.embabel.demo.model.story.Story;
import com.embabel.demo.model.story.StoryReview;
import com.embabel.demo.prompt.persona.StoryPersonas;
import jakarta.annotation.Nullable;
import java.time.LocalDate;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.IntStream;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Profile;

/**
 * Based on StoryAgent in
 * <a href="https://github.com/embabel/java-agent-template/blob/main/src/main/java/com/embabel/template/agent/WriteAndReviewAgent.java">java-agent-template</a>.
 */
@Agent(description = "Generate stories based on user input, review them, and return the best one")
@Profile("!test")
public class StoryAgent {

    private static final Logger LOG = LoggerFactory.getLogger(StoryAgent.class);
    private static final int MAX_RETRIES = 3;

    private final int storyCount;
    private final int storyWordCount;
    private final int reviewWordCount;

    public StoryAgent(
            @Value("${storyCount:3}") int storyCount,
            @Value("${storyWordCount:500}") int storyWordCount,
            @Value("${reviewWordCount:100}") int reviewWordCount
    ) {
        this.storyCount = storyCount;
        this.storyWordCount = storyWordCount;
        this.reviewWordCount = reviewWordCount;
    }

    @Action
    public Stories writeStories(UserInput userInput, OperationContext context) {
        List<String> storyTexts = IntStream.range(0, storyCount).parallel().mapToObj(i ->
                retry("writeStory", () ->
                        context.ai()
                                .withLlm(LlmOptions.withLlmForRole("best"))
                                .withPromptContributor(StoryPersonas.WRITER)
                                .withTemplate("story/write-story-template.jinja")
                                .createObject(String.class,
                                        Map.of(
                                                "storyWordCount", storyWordCount,
                                                "currentDate", LocalDate.now().toString(),
                                                "userInput", userInput.getContent()
                                        )))
        ).filter(Objects::nonNull).toList();
        List<Story> stories = storyTexts.stream().map(Story::new).toList();
        return new Stories(stories);
    }

    @Action
    public ReviewedStories reviewStories(UserInput userInput, Stories stories, OperationContext context) {
        List<ReviewedStory> reviewed = stories.stories().stream().parallel().map(story ->
                retry("reviewStory", () -> {
                    var review = context.ai()
                            .withLlm(LlmOptions.withLlmForRole("cheapest"))
                            .withPromptContributor(StoryPersonas.REVIEWER)
                            .withTemplate("story/review-story-template.jinja")
                            .createObject(StoryReview.class,
                                    Map.of(
                                            "reviewWordCount", reviewWordCount,
                                            "story", story.text(),
                                            "userInput", userInput.getContent()
                                    ));
                    return new ReviewedStory(story, review, StoryPersonas.REVIEWER);
                })
        ).filter(Objects::nonNull).toList();
        return new ReviewedStories(reviewed);
    }

    private <T> @Nullable T retry(String operationName, java.util.function.Supplier<T> operation) {
        for (int attempt = 1; attempt <= MAX_RETRIES; attempt++) {
            try {
                return operation.get();
            } catch (Exception e) {
                LOG.warn("{} failed on attempt {}/{}: {}", operationName, attempt, MAX_RETRIES, e.getMessage());
            }
        }
        LOG.error("{} failed after {} attempts, skipping", operationName, MAX_RETRIES);
        return null;
    }

    @AchievesGoal(
            description = "Stories have been crafted, reviewed, and the best one selected",
            export = @Export(remote = true, name = "story", startingInputTypes = {UserInput.class}))
    @Action
    public Story selectBestStory(ReviewedStories reviewedStories) {
        return reviewedStories.reviewedStories().stream()
                .max(Comparator.comparingInt(rs -> rs.review().rating()))
                .map(ReviewedStory::story)
                .orElseThrow();
    }
}
