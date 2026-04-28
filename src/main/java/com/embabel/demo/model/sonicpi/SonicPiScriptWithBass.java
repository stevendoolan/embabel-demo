package com.embabel.demo.model.sonicpi;

import jakarta.annotation.Nonnull;

/**
 * Holds the generated Sonic Pi Ruby code for the bass track. Produced by the {@code addBass}
 * action, which writes low-register bass lines that provide the harmonic and rhythmic foundation
 * underneath the melody. Fed into the {@code combineAllSonicPiScripts} action to create the
 * final arrangement.
 */
public record SonicPiScriptWithBass(
        @Nonnull String scriptContent) {
}
