package com.embabel.demo.model.sonicpi;

public record SonicPiRequest(
        String songTitle,
        String mood,
        String instruments,
        String style,
        String melodyDescription,
        String backgroundTrackDescription) {
}
