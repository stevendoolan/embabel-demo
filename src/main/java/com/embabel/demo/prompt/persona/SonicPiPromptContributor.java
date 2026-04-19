package com.embabel.demo.prompt.persona;

import com.embabel.common.ai.prompt.PromptContributor;
import jakarta.annotation.Nonnull;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties("sonic-pi")
public record SonicPiPromptContributor(
        @Nonnull String instructions,
        @Nonnull List<String> instruments,
        @Nonnull List<String> samples
) implements PromptContributor {

    @Override
    public @Nonnull String contribution() {
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

    private static @Nonnull String toJSONList(@Nonnull List<String> items) {
        return items.stream()
                .map("\"%s\""::formatted)
                .collect(Collectors.joining(", "));
    }
}
