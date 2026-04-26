package com.embabel.demo.model.sonicpi;

import jakarta.annotation.Nonnull;

/**
 * An entry in the Sonic Pi example store, mapping a {@code .rb} file to its LLM-extracted
 * metadata and an eligibility flag for prompt injection.
 *
 * @param relativePath  path relative to the {@code sonic-pi-examples/} root folder
 * @param sonicPiMetadata LLM-extracted metadata describing the musical characteristics
 * @param allowedToUse  whether this example is eligible for prompt injection
 */
public record SonicPiExampleStoreEntry(
        @Nonnull String relativePath,
        @Nonnull SonicPiMetadata sonicPiMetadata,
        boolean allowedToUse) {
}
