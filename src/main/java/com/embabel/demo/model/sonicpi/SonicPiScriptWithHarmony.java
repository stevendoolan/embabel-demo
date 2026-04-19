package com.embabel.demo.model.sonicpi;

import jakarta.annotation.Nonnull;

/**
 * Holds the generated Sonic Pi Ruby code for the harmony track. Produced by the {@code addHarmony}
 * action, which writes chords and progressions that complement the existing melody. Fed into the
 * {@code combineAllSonicPiScripts} action to create the final arrangement.
 */
public record SonicPiScriptWithHarmony(
        @Nonnull String scriptContent) {
}
