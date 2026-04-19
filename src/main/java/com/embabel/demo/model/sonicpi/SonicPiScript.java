package com.embabel.demo.model.sonicpi;

import jakarta.annotation.Nonnull;

public record SonicPiScript(
        @Nonnull SonicPiMetadata sonicPiMetadata,
        @Nonnull SonicPiCompleteScript completeScript) {

    public @Nonnull String filename() {
        return "sonic_pi_script_%s.rb".formatted(System.currentTimeMillis());
    }
}
