package com.embabel.demo.model.sonicpi;

import jakarta.annotation.Nonnull;

/**
 * Pairs the extracted {@link SonicPiMetadata} with the {@link SonicPiCompleteScript} to represent
 * a fully generated Sonic Pi song, including both its musical properties and the runnable Ruby code.
 * Provides a {@link #filename()} helper to generate a timestamped output file name.
 */
public record SonicPiScript(
        @Nonnull SonicPiMetadata sonicPiMetadata,
        @Nonnull SonicPiCompleteScript completeScript) {

    public @Nonnull String filename() {
        return "sonic_pi_script_%s.rb".formatted(System.currentTimeMillis());
    }
}
