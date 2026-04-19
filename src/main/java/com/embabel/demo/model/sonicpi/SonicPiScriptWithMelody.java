package com.embabel.demo.model.sonicpi;

import jakarta.annotation.Nonnull;

/**
 * Holds the generated Sonic Pi Ruby code for the melody track. Produced by the {@code createMelody}
 * action and passed to the harmony, percussion, and combine actions as the foundation that other
 * tracks build upon.
 */
public record SonicPiScriptWithMelody(
        @Nonnull String scriptContent) {
}
