package com.embabel.demo.prompt.persona;

import com.embabel.common.ai.prompt.PromptContributor;
import com.embabel.demo.model.sonicpi.ExampleSong;
import jakarta.annotation.Nonnull;
import jakarta.annotation.Nullable;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Stream;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

/**
 * Loads Sonic Pi {@code .rb} example songs from configured directories at startup and contributes
 * them to LLM prompts as few-shot context. Created because the Sonic Pi agent produces significantly
 * richer, more idiomatic music when the LLM can learn from concrete examples of real songs.
 *
 * <p>Recursively scans two optional directories (Sonic Pi's built-in examples and the user's
 * personal collection) and caps the total at {@code maxExamples} to avoid exceeding context limits.
 * Gracefully handles missing or unreadable directories.
 */
@Component
public class SonicPiExamplesContributor implements PromptContributor {

    private static final Logger LOG = LoggerFactory.getLogger(SonicPiExamplesContributor.class);

    private final List<ExampleSong> examples;

    public SonicPiExamplesContributor(@Nonnull SonicPiExamplesProperties properties) {
        List<ExampleSong> loaded = new ArrayList<>();
        loadFromDirectory(properties.sonicPiAppDir(), loaded);
        loadFromDirectory(properties.userDir(), loaded);

        if (loaded.size() > properties.maxExamples()) {
            Collections.shuffle(loaded);
            loaded = loaded.subList(0, properties.maxExamples());
        }

        this.examples = List.copyOf(loaded);
        LOG.info("Loaded {} Sonic Pi example songs for few-shot prompting", examples.size());
    }

    @Override
    public @Nonnull String contribution() {
        if (examples.isEmpty()) {
            return "";
        }

        var sb = new StringBuilder();
        sb.append("""
                Here are example Sonic Pi songs to learn from. \
                Study these examples carefully and use them as inspiration for idiomatic Sonic Pi patterns, \
                richer arrangements, and more musical structures:

                """);

        for (var example : examples) {
            sb.append("<example name=\"%s\">\n".formatted(example.name()));
            sb.append(example.content());
            sb.append("\n</example>\n\n");
        }

        return sb.toString();
    }

    private void loadFromDirectory(@Nullable String dirPath, @Nonnull List<ExampleSong> target) {
        if (dirPath == null || dirPath.isBlank()) {
            LOG.info("Sonic Pi examples directory not configured (null or blank)");
            return;
        }

        var resolved = Path.of(dirPath).toAbsolutePath().normalize();
        LOG.info("Loading Sonic Pi examples from: {}", resolved);
        if (!Files.isDirectory(resolved)) {
            LOG.warn("Sonic Pi examples directory does not exist: {}", resolved);
            return;
        }

        int countBefore = target.size();
        try (Stream<Path> walk = Files.walk(resolved)) {
            walk.filter(Files::isRegularFile)
                    .filter(p -> p.toString().endsWith(".rb"))
                    .forEach(p -> {
                        try {
                            var content = Files.readString(p);
                            var name = resolved.relativize(p).toString();
                            target.add(new ExampleSong(name, content));
                            LOG.info("  Loaded example song: {}", name);
                        } catch (IOException e) {
                            LOG.warn("Failed to read example file: {}", p, e);
                        }
                    });
        } catch (IOException e) {
            LOG.warn("Failed to scan directory: {}", resolved, e);
        }

        int loaded = target.size() - countBefore;
        LOG.info("Loaded {} example songs from {}", loaded, resolved);
    }

}
