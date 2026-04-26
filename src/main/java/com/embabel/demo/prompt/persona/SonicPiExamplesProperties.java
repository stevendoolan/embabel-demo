package com.embabel.demo.prompt.persona;

import jakarta.annotation.Nonnull;
import jakarta.annotation.Nullable;
import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * Configuration properties for locating Sonic Pi example songs on the local filesystem.
 * Created to allow the Sonic Pi agent to load real {@code .rb} songs as few-shot examples,
 * dramatically improving the quality of LLM-generated music.
 *
 * @param storeDir    path to the {@code sonic-pi-examples/} root directory containing the
 *                    {@code .rb} example files
 * @param storeFile   optional path to {@code store.json}; defaults to {@code store.json} inside
 *                    {@code storeDir}. Use a separate writable path when the examples directory
 *                    is read-only (e.g. a Docker volume mounted with {@code :ro}).
 * @param maxExamples maximum number of example songs to include in prompts, to bound context size
 */
@ConfigurationProperties("sonic-pi.examples")
public record SonicPiExamplesProperties(
        @Nonnull String storeDir,
        @Nullable String storeFile,
        int maxExamples
) {
}
