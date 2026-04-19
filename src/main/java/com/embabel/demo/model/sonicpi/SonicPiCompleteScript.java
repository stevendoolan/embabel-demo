package com.embabel.demo.model.sonicpi;

import jakarta.annotation.Nonnull;

/**
 * Holds the final combined Sonic Pi Ruby script after all tracks (melody, harmony, percussion)
 * have been merged into a single runnable script. Used as part of {@link SonicPiScript} to pair
 * the finished code with its metadata.
 */
public record SonicPiCompleteScript(
        @Nonnull String scriptContent) {
}
