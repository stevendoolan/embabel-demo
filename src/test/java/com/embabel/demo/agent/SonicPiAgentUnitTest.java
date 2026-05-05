package com.embabel.demo.agent;

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.Test;

class SonicPiAgentUnitTest {

    @Test
    void stripsRubyFences() {
        var fenced = """
                ```ruby
                use_bpm 120
                play 60
                ```""";
        assertThat(SonicPiAgent.stripMarkdownFences(fenced))
                .isEqualTo("use_bpm 120\nplay 60");
    }

    @Test
    void stripsBareFences() {
        var fenced = """
                ```
                use_bpm 120
                play 60
                ```""";
        assertThat(SonicPiAgent.stripMarkdownFences(fenced))
                .isEqualTo("use_bpm 120\nplay 60");
    }

    @Test
    void stripsFencesWithSurroundingWhitespace() {
        var fenced = "\n\n```ruby\nuse_bpm 120\nplay 60\n```\n\n";
        assertThat(SonicPiAgent.stripMarkdownFences(fenced))
                .isEqualTo("use_bpm 120\nplay 60");
    }

    @Test
    void leavesUnfencedScriptUnchanged() {
        var unfenced = "use_bpm 120\nplay 60\n";
        assertThat(SonicPiAgent.stripMarkdownFences(unfenced)).isEqualTo(unfenced);
    }

    @Test
    void leavesScriptWithInternalFencesUnchanged() {
        // Defensive: a script that mentions ``` in a comment but isn't wrapped should be untouched.
        var script = "# Example: ```ruby ... ```\nuse_bpm 120\nplay 60";
        assertThat(SonicPiAgent.stripMarkdownFences(script)).isEqualTo(script);
    }

    @Test
    void handlesNull() {
        assertThat(SonicPiAgent.stripMarkdownFences(null)).isNull();
    }
}
