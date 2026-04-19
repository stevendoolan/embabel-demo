package com.embabel.demo.model.sonicpi;

import jakarta.annotation.Nonnull;

/**
 * Represents a Sonic Pi song loaded from disk, used as a few-shot example in LLM prompts
 * to improve the quality of generated music.
 *
 * @param name    relative file path within the source directory (e.g. "apprentice/bach.rb")
 * @param content the full Ruby source code of the song
 */
public record ExampleSong(
        @Nonnull String name,
        @Nonnull String content) {
}
