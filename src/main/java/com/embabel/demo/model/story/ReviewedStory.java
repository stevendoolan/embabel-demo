package com.embabel.demo.model.story;

import com.embabel.agent.domain.library.HasContent;
import com.embabel.agent.prompt.persona.Persona;
import com.embabel.common.core.types.Timestamped;
import java.time.Instant;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import org.springframework.lang.NonNull;

public record ReviewedStory(
        Story story,
        String review,
        Persona reviewer
) implements HasContent, Timestamped {

    @Override
    @NonNull
    public Instant getTimestamp() {
        return Instant.now();
    }

    @Override
    @NonNull
    public String getContent() {
        return String.format("""
                        # Story
                        %s
                        
                        # Review
                        %s
                        
                        # Reviewer
                        %s, %s
                        """,
                story.text(),
                review,
                reviewer.getName(),
                getTimestamp().atZone(ZoneId.systemDefault())
                        .format(DateTimeFormatter.ofPattern("EEEE, MMMM dd, yyyy"))
        ).trim();
    }
}
