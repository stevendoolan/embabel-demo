package com.embabel.demo.prompt.persona;

import com.embabel.agent.api.common.Ai;
import com.embabel.common.ai.prompt.PromptContributor;
import com.embabel.demo.model.sonicpi.MatchingExamples;
import com.embabel.demo.model.sonicpi.SonicPiExampleStoreEntry;
import com.embabel.demo.model.sonicpi.SonicPiMetadata;
import com.embabel.demo.service.SonicPiExampleIndexer;
import jakarta.annotation.Nonnull;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
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

    private static final String FAVOURITE_PATH_SEGMENT = "/favourite/";

    private final SonicPiExampleStore store;
    private final SonicPiExampleIndexer indexer;
    private final SonicPiExamplesProperties properties;
    private final Ai ai;

    public SonicPiExamplesContributor(@Nonnull SonicPiExampleStore store,
                                     @Nonnull SonicPiExampleIndexer indexer,
                                     @Nonnull SonicPiExamplesProperties properties,
                                     @Nonnull Ai ai) {
        this.store = store;
        this.indexer = indexer;
        this.properties = properties;
        this.ai = ai;
    }

    /**
     * Fallback contribution used by actions without metadata. Always includes all favourites and
     * fills the remaining {@code maxExamples} slots with other allowed examples.
     */
    @Override
    public @Nonnull String contribution() {
        List<SonicPiExampleStoreEntry> allowed = getAllowedEntries();
        if (allowed.isEmpty()) {
            return "";
        }

        List<SonicPiExampleStoreEntry> favourites = allowed.stream()
                .filter(SonicPiExamplesContributor::isFavourite)
                .toList();
        List<SonicPiExampleStoreEntry> nonFavourites = allowed.stream()
                .filter(entry -> !isFavourite(entry))
                .toList();

        int remainingSlots = Math.max(0, properties.maxExamples() - favourites.size());
        List<SonicPiExampleStoreEntry> combined = new ArrayList<>(favourites);
        combined.addAll(nonFavourites.stream().limit(remainingSlots).toList());
        return formatExamples(combined);
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

        List<SonicPiExampleStoreEntry> favourites = allowed.stream()
                .filter(SonicPiExamplesContributor::isFavourite)
                .toList();
        List<SonicPiExampleStoreEntry> nonFavourites = allowed.stream()
                .filter(entry -> !isFavourite(entry))
                .toList();

        int remainingSlots = Math.max(0, properties.maxExamples() - favourites.size());

        try {
            List<SonicPiExampleStoreEntry> matched;
            if (nonFavourites.isEmpty() || remainingSlots == 0) {
                matched = List.of();
            } else {
                List<String> matchingPaths = selectMatchingExamples(targetMetadata, nonFavourites, remainingSlots);
                matched = nonFavourites.stream()
                        .filter(entry -> matchingPaths.contains(entry.relativePath()))
                        .limit(remainingSlots)
                        .toList();
            }

            if (matched.isEmpty()) {
                LOG.info(
                        "LLM found no matching examples out of {} non-favourite allowed entries. To improve future generations, add examples with: style='{}', mood='{}', tempo~{} BPM, key='{}', melody instruments=[{}], harmony instruments=[{}], percussion samples=[{}]",
                        nonFavourites.size(),
                        targetMetadata.style(),
                        targetMetadata.mood(),
                        targetMetadata.tempoBpm(),
                        targetMetadata.key(),
                        String.join(", ", targetMetadata.melodyInstruments()),
                        String.join(", ", targetMetadata.harmonyInstruments()),
                        String.join(", ", targetMetadata.percussionSamples()));
            } else {
                List<String> matchedPaths = matched.stream().map(SonicPiExampleStoreEntry::relativePath).toList();
                LOG.info("LLM selected {} matching examples out of {} non-favourite allowed: {}",
                        matched.size(), nonFavourites.size(), matchedPaths);
            }

            List<SonicPiExampleStoreEntry> combined = new ArrayList<>(favourites);
            combined.addAll(matched);
            if (!favourites.isEmpty()) {
                List<String> favouritePaths = favourites.stream().map(SonicPiExampleStoreEntry::relativePath).toList();
                LOG.info("Always including {} favourite example(s): {}", favourites.size(), favouritePaths);
            }
            return formatExamples(combined);
        } catch (Exception e) {
            LOG.warn("LLM example selection failed — falling back to favourites plus all allowed examples", e);
            List<SonicPiExampleStoreEntry> fallback = new ArrayList<>(favourites);
            fallback.addAll(nonFavourites.stream().limit(remainingSlots).toList());
            return formatExamples(fallback);
        }
    }

    private static boolean isFavourite(@Nonnull SonicPiExampleStoreEntry entry) {
        String normalised = "/" + entry.relativePath().replace('\\', '/') + "/";
        return normalised.contains(FAVOURITE_PATH_SEGMENT);
    }

    private @Nonnull List<SonicPiExampleStoreEntry> getAllowedEntries() {
        return store.getEntries().stream()
                .filter(SonicPiExampleStoreEntry::allowedToUse)
                .toList();
    }

    private @Nonnull List<String> selectMatchingExamples(
            @Nonnull SonicPiMetadata targetMetadata,
            @Nonnull List<SonicPiExampleStoreEntry> candidates,
            int maxToSelect) {

        List<Map<String, Object>> candidatePayload = candidates.stream()
                .map(entry -> Map.<String, Object>of(
                        "relativePath", entry.relativePath(),
                        "style", entry.sonicPiMetadata().style(),
                        "mood", entry.sonicPiMetadata().mood(),
                        "tempoBpm", entry.sonicPiMetadata().tempoBpm(),
                        "key", entry.sonicPiMetadata().key(),
                        "melodyInstruments", String.join(", ", entry.sonicPiMetadata().melodyInstruments())))
                .toList();

        MatchingExamples selection = ai.withDefaultLlm()
                .withTemplate("sonicpi/select-matching-examples.jinja")
                .createObject(MatchingExamples.class, Map.of(
                        "targetStyle", targetMetadata.style(),
                        "targetMood", targetMetadata.mood(),
                        "targetTempoBpm", String.valueOf(targetMetadata.tempoBpm()),
                        "targetKey", targetMetadata.key(),
                        "targetMelodyInstruments", String.join(", ", targetMetadata.melodyInstruments()),
                        "targetHarmonyInstruments", String.join(", ", targetMetadata.harmonyInstruments()),
                        "targetPercussionSamples", String.join(", ", targetMetadata.percussionSamples()),
                        "examples", candidatePayload,
                        "maxExamples", String.valueOf(maxToSelect)));

        return selection.matchingPaths() == null ? List.of() : selection.matchingPaths();
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

        for (var entry : entries) {
            String content = contentMap.get("./" + entry.relativePath());
            if (content == null) {
                LOG.debug("No file content found for {}", entry.relativePath());
            } else {
                sb.append("<example name=\"%s\" style=\"%s\" mood=\"%s\" tempo=\"%d\">\n".formatted(
                        entry.relativePath(),
                        entry.sonicPiMetadata().style(),
                        entry.sonicPiMetadata().mood(),
                        entry.sonicPiMetadata().tempoBpm()));
                sb.append(content);
                sb.append("\n</example>\n\n");
            }
        }

        return sb.toString();
    }
}
