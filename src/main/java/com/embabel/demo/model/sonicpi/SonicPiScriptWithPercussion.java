package com.embabel.demo.model.sonicpi;

import jakarta.annotation.Nonnull;

/**
 * Holds the generated Sonic Pi Ruby code for the percussion track. Produced by the
 * {@code addPercussion} action using samples only (no instruments). Fed into the
 * {@code combineAllSonicPiScripts} action to create the final arrangement.
 */
public record SonicPiScriptWithPercussion(
        @Nonnull String scriptContent) {
}
