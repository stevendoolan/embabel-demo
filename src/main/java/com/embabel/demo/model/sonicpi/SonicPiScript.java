package com.embabel.demo.model.sonicpi;

import org.jetbrains.annotations.NotNull;

public record SonicPiScript(
        SonicPiMetadata sonicPiMetadata,
        SonicPiCompleteScript completeScript) {

    public @NotNull String filename() {
        return "sonic_pi_script_%s.rb".formatted(System.currentTimeMillis());
    }
}
