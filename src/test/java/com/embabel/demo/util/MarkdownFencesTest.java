package com.embabel.demo.util;

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.Test;

class MarkdownFencesTest {

    @Test
    void stripsLanguageTaggedFences() {
        var fenced = """
                ```ruby
                use_bpm 120
                play 60
                ```""";
        assertThat(MarkdownFences.strip(fenced)).isEqualTo("use_bpm 120\nplay 60");
    }

    @Test
    void stripsBareFences() {
        var fenced = """
                ```
                use_bpm 120
                play 60
                ```""";
        assertThat(MarkdownFences.strip(fenced)).isEqualTo("use_bpm 120\nplay 60");
    }

    @Test
    void stripsFencesWithSurroundingWhitespace() {
        var fenced = "\n\n```ruby\nuse_bpm 120\nplay 60\n```\n\n";
        assertThat(MarkdownFences.strip(fenced)).isEqualTo("use_bpm 120\nplay 60");
    }

    @Test
    void leavesUnfencedContentUnchanged() {
        var unfenced = "use_bpm 120\nplay 60\n";
        assertThat(MarkdownFences.strip(unfenced)).isEqualTo(unfenced);
    }

    @Test
    void leavesContentWithInternalFencesUnchanged() {
        // A script that mentions ``` in a comment but isn't wrapped should be untouched.
        var content = "# Example: ```ruby ... ```\nuse_bpm 120\nplay 60";
        assertThat(MarkdownFences.strip(content)).isEqualTo(content);
    }

    @Test
    void handlesNull() {
        assertThat(MarkdownFences.strip(null)).isNull();
    }
}
