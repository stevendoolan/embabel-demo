package com.embabel.demo.prompt.persona;

import com.embabel.agent.api.common.Ai;
import com.embabel.common.ai.prompt.PromptContributor;
import com.embabel.demo.model.sonicpi.SonicPiExampleStoreEntry;
import com.embabel.demo.model.sonicpi.SonicPiMetadata;
import com.embabel.demo.service.SonicPiExampleIndexer;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.annotation.Nonnull;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

/**
 * Contributes Sonic Pi example songs to LLM prompts as few-shot context. Uses the
 * {@link SonicPiExampleStore} for metadata and the {@link SonicPiExampleIndexer} for file content.
 *
 * <p>The {@link #contributionFor(SonicPiMetadata)} method performs LLM-based loose matching to
 * select only the examples whose musical characteristics are relevant to the current generation
 * request. The {@link #contribution()} method provides a fallback that includes all allowed examples.
 */
@Component
public class SonicPiExamplesContributor implements PromptContributor {

    private static final Logger LOG = LoggerFactory.getLogger(SonicPiExamplesContributor.class);

    private final SonicPiExampleStore store;
    private final SonicPiExampleIndexer indexer;
    private final SonicPiExamplesProperties properties;
    private final Ai ai;
    private final ObjectMapper objectMapper;

    public SonicPiExamplesContributor(@Nonnull SonicPiExampleStore store,
                                     @Nonnull SonicPiExampleIndexer indexer,
                                     @Nonnull SonicPiExamplesProperties properties,
                                     @Nonnull Ai ai) {
        this.store = store;
        this.indexer = indexer;
        this.properties = properties;
        this.ai = ai;
        this.objectMapper = new ObjectMapper();
    }

    /**
     * Fallback contribution that includes all allowed examples (used by actions without metadata).
     */
    @Override
    public @Nonnull String contribution() {
        List<SonicPiExampleStoreEntry> allowed = getAllowedEntries();
        return formatExamples(allowed);
    }

    /**
     * Selects examples that loosely match the given metadata using an LLM call, then returns
     * the formatted prompt contribution containing only the matching examples' file content.
     *
     * <p>Falls back to all allowed examples if the LLM matching call fails.
     */
    public @Nonnull String contributionFor(@Nonnull SonicPiMetadata targetMetadata) {
        List<SonicPiExampleStoreEntry> allowed = getAllowedEntries();
        if (allowed.isEmpty()) {
            return "";
        }

        try {
            List<String> matchingPaths = selectMatchingExamples(targetMetadata, allowed);
            List<SonicPiExampleStoreEntry> matched = allowed.stream()
                    .filter(entry -> matchingPaths.contains(entry.relativePath()))
                    .toList();

            LOG.info("LLM selected {} matching examples out of {} allowed", matched.size(), allowed.size());
            return formatExamples(matched);
        } catch (Exception e) {
            LOG.warn("LLM example selection failed — falling back to all allowed examples", e);
            return formatExamples(allowed);
        }
    }

    private @Nonnull List<SonicPiExampleStoreEntry> getAllowedEntries() {
        return store.getEntries().stream()
                .filter(SonicPiExampleStoreEntry::allowedToUse)
                .toList();
    }

    private @Nonnull List<String> selectMatchingExamples(
            @Nonnull SonicPiMetadata targetMetadata,
            @Nonnull List<SonicPiExampleStoreEntry> candidates) throws IOException {

        String response = ai.withDefaultLlm()
                .withTemplate("sonicpi/select-matching-examples.jinja")
                .createObject(String.class, Map.of(
                        "targetStyle", targetMetadata.style(),
                        "targetMood", targetMetadata.mood(),
                        "targetTempoBpm", String.valueOf(targetMetadata.tempoBpm()),
                        "targetKey", targetMetadata.key(),
                        "targetMelodyInstruments", String.join(", ", targetMetadata.melodyInstruments()),
                        "targetHarmonyInstruments", String.join(", ", targetMetadata.harmonyInstruments()),
                        "targetPercussionSamples", String.join(", ", targetMetadata.percussionSamples()),
                        "examples", candidates,
                        "maxExamples", String.valueOf(properties.maxExamples())));

        return objectMapper.readValue(response, new TypeReference<>() {
        });
    }

    private @Nonnull String formatExamples(@Nonnull List<SonicPiExampleStoreEntry> entries) {
        Map<String, String> contentMap = indexer.getFileContentMap();
        if (entries.isEmpty() || contentMap.isEmpty()) {
            return "";
        }

        var sb = new StringBuilder();
        sb.append("""
                Here are example Sonic Pi songs to learn from.
                Study these examples carefully and use them as inspiration for idiomatic Sonic Pi patterns,
                richer arrangements, and more musical structures:

                """);

        int count = 0;
        for (var entry : entries) {
            if (count >= properties.maxExamples()) {
                break;
            }

            String content = contentMap.get("./" + entry.relativePath());
            if (content == null) {
                LOG.debug("No file content found for {}", entry.relativePath());
                continue;
            }

            sb.append("<example name=\"%s\" style=\"%s\" mood=\"%s\" tempo=\"%d\">\n".formatted(
                    entry.relativePath(),
                    entry.sonicPiMetadata().style(),
                    entry.sonicPiMetadata().mood(),
                    entry.sonicPiMetadata().tempoBpm()));
            sb.append(content);
            sb.append("\n</example>\n\n");
            count++;
        }

        return sb.toString();
    }
}
