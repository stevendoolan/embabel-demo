package com.embabel.demo.prompt.persona;

import com.embabel.common.ai.prompt.PromptContributor;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Stream;
import org.jetbrains.annotations.NotNull;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Component
public class SonicPiExamplesContributor implements PromptContributor {

    private static final Logger LOG = LoggerFactory.getLogger(SonicPiExamplesContributor.class);

    private final List<ExampleSong> examples;

    public SonicPiExamplesContributor(SonicPiExamplesProperties properties) {
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

    @NotNull
    @Override
    public String contribution() {
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

    private void loadFromDirectory(String dirPath, List<ExampleSong> target) {
        if (dirPath == null || dirPath.isBlank()) {
            return;
        }

        var resolved = resolvePath(dirPath);
        if (!Files.isDirectory(resolved)) {
            LOG.warn("Sonic Pi examples directory does not exist: {}", resolved);
            return;
        }

        try (Stream<Path> walk = Files.walk(resolved)) {
            walk.filter(Files::isRegularFile)
                    .filter(p -> p.toString().endsWith(".rb"))
                    .forEach(p -> {
                        try {
                            var content = Files.readString(p);
                            var name = resolved.relativize(p).toString();
                            target.add(new ExampleSong(name, content));
                        } catch (IOException e) {
                            LOG.warn("Failed to read example file: {}", p, e);
                        }
                    });
        } catch (IOException e) {
            LOG.warn("Failed to scan directory: {}", resolved, e);
        }

        LOG.info("Loaded {} example songs from {}", target.size(), resolved);
    }

    private static Path resolvePath(String path) {
        if (path.startsWith("~")) {
            return Path.of(System.getProperty("user.home") + path.substring(1));
        }
        return Path.of(path);
    }

    private record ExampleSong(String name, String content) {
    }
}
