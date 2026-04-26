package com.embabel.demo.prompt.persona;

import jakarta.annotation.Nonnull;
import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * Configuration properties for locating Sonic Pi example songs on the local filesystem.
 * Created to allow the Sonic Pi agent to load real {@code .rb} songs as few-shot examples,
 * dramatically improving the quality of LLM-generated music.
 *
 * @param storeDir    path to the {@code sonic-pi-examples/} root directory containing {@code store.json}
 *                    and the {@code .rb} example files
 * @param maxExamples maximum number of example songs to include in prompts, to bound context size
 */
@ConfigurationProperties("sonic-pi.examples")
public record SonicPiExamplesProperties(
        @Nonnull String storeDir,
        int maxExamples
) {
}
