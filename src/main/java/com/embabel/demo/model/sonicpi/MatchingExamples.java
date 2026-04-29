package com.embabel.demo.model.sonicpi;

import jakarta.annotation.Nonnull;
import java.util.List;

/**
 * Structured response from the LLM example-selection prompt. Wrapping the list in a record
 * forces the framework's structured-output mode to return a JSON object matching this schema,
 * which prevents the LLM from wrapping the list in prose like "I have selected: [...]".
 */
public record MatchingExamples(@Nonnull List<String> matchingPaths) {
}
