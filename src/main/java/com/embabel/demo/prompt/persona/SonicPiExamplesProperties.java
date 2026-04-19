package com.embabel.demo.prompt.persona;

import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties("sonic-pi.examples")
public record SonicPiExamplesProperties(
        String sonicPiAppDir,
        String userDir,
        int maxExamples
) {
}
