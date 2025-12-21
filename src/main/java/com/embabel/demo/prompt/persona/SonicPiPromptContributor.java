package com.embabel.demo.prompt.persona;

import com.embabel.common.ai.prompt.PromptContributor;
import java.util.List;
import java.util.stream.Collectors;
import org.jetbrains.annotations.NotNull;
import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties("sonic-pi")
public record SonicPiPromptContributor(
        @NotNull String instructions,
        @NotNull List<String> instruments,
        @NotNull List<String> samples
) implements PromptContributor {

    @NotNull
    @Override
    public String contribution() {
        return """
                %s
                
                Only these instruments are available in Sonic Pi:
                {"instruments":[%s]}
                
                Only these samples are available in Sonic Pi:
                {"samples":[%s]}
                """.formatted(
                instructions,
                toJSONList(instruments),
                toJSONList(samples));
    }

    private static @NotNull String toJSONList(@NotNull List<String> items) {
        return items.stream()
                .map("\"%s\""::formatted)
                .collect(Collectors.joining(", "));
    }
}
