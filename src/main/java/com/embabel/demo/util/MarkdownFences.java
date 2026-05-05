package com.embabel.demo.util;

import java.util.regex.Pattern;

public final class MarkdownFences {

    private static final Pattern FENCE = Pattern.compile(
            "\\A\\s*```(?:[A-Za-z0-9_+-]*)\\s*\\R(.*?)\\R\\s*```\\s*\\z",
            Pattern.DOTALL);

    private MarkdownFences() {
    }

    public static String strip(String content) {
        if (content == null) {
            return null;
        }
        var matcher = FENCE.matcher(content);
        return matcher.matches() ? matcher.group(1) : content;
    }
}
