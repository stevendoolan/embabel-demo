package com.embabel.demo.prompt.persona;

import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * Configuration properties for locating Sonic Pi example songs on the local filesystem.
 * Created to allow the Sonic Pi agent to load real {@code .rb} songs as few-shot examples,
 * dramatically improving the quality of LLM-generated music.
 *
 * @param sonicPiAppDir path to Sonic Pi's built-in examples directory (may be null if not installed)
 * @param userDir       path to the user's personal Sonic Pi song collection (may be null)
 * @param maxExamples   maximum number of example songs to include in prompts, to bound context size
 */
@ConfigurationProperties("sonic-pi.examples")
public record SonicPiExamplesProperties(
        String sonicPiAppDir,
        String userDir,
        int maxExamples
) {
}
