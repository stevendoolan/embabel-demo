package com.embabel.demo.model.sonicpi;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Pattern;
import java.util.List;

/**
 * Structured metadata extracted from a user's free-text music prompt by the LLM. Captures the
 * musical properties (key, tempo, time signature, mood, instruments, etc.) needed to drive the
 * multi-step Sonic Pi code generation pipeline. Produced by the {@code toSonicPiMetadata} action
 * and consumed by every subsequent generation action in {@link com.embabel.demo.agent.SonicPiAgent}.
 */
public record SonicPiMetadata(

        @NotBlank(message = "Must not be blank.")
        String songTitle,

        @NotBlank(message = "Must not be blank.")
        String composerName,

        @NotBlank(message = "Must not be blank.")
        String key,

        @NotBlank(message = "Must not be blank.")
        String keyChange,

        @Min(value = 40, message = "Tempo must be at least 40 BPM.")
        @Max(value = 300, message = "Tempo must be at most 300 BPM.")
        int tempoBpm,

        @NotBlank(message = "Must not be blank.")
        String timeSignature,

        @Min(value = 2, message = "Must be at least 2.")
        int measures,

        @NotBlank(message = "Must not be blank.")
        String mood,

        @NotEmpty(message = "At least one instrument must be specified.")
        List<String> melodyInstruments,

        @NotEmpty(message = "At least one instrument must be specified.")
        List<String> harmonyInstruments,

        @NotEmpty(message = "At least one sample must be specified.")
        List<String> percussionSamples,

        @NotEmpty(message = "At least one instrument must be specified.")
        List<String> bassInstruments,

        @NotBlank(message = "Must not be blank.")
        String style,

        @NotBlank(message = "Must not be blank.")
        String melodyDescription,

        @NotBlank(message = "Must not be blank.")
        String harmonyDescription,

        @NotBlank(message = "Must not be blank.")
        String percussionDescription,

        @NotBlank(message = "Must not be blank.")
        String bassDescription) {
}
