package com.embabel.demo.config.models.openai;

import static com.embabel.demo.config.models.LegacyOpenAiModels.GPT_4O;
import static com.embabel.demo.config.models.LegacyOpenAiModels.GPT_4O_LITE;

import com.embabel.agent.config.models.OpenAiModels;
import com.embabel.agent.config.models.openai.OpenAiModelsConfig;
import com.embabel.agent.config.models.openai.OpenAiProperties;
import com.embabel.common.ai.model.Llm;
import com.embabel.common.ai.model.LlmOptions;
import com.embabel.common.ai.model.OptionsConverter;
import com.embabel.common.ai.model.PerTokenPricingModel;
import java.time.LocalDate;
import org.jetbrains.annotations.NotNull;
import org.springframework.ai.openai.OpenAiChatOptions;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;

/**
 * Configures extra Open AI models that are not provided out-of-the-box by Embabel.
 * Based on {@link OpenAiModelsConfig}.
 */
@Configuration(proxyBeanMethods = false)
@Profile("openai")
@ConditionalOnProperty("OPENAI_API_KEY")
public class LegacyOpenAiModelsConfig {

    private final OpenAiModelsConfig openAiModelsConfig;
    private final OpenAiProperties properties;

    public LegacyOpenAiModelsConfig(
            OpenAiModelsConfig openAiModelsConfig,
            OpenAiProperties properties) {
        this.openAiModelsConfig = openAiModelsConfig;
        this.properties = properties;
    }

    @Bean
    public Llm gpt4o() {
        return openAiModelsConfig.openAiCompatibleLlm(
                GPT_4O,
                // TODO Find correct pricing
                new PerTokenPricingModel(0.003, 0.006),
                OpenAiModels.PROVIDER,
                LocalDate.of(2025, 1, 1),
                new LegacyOptionsConverter(),
                properties.retryTemplate(GPT_4O)
        );
    }

    @Bean
    public Llm gpt4oLite() {
        return openAiModelsConfig.openAiCompatibleLlm(
                GPT_4O_LITE,
                // TODO Find correct pricing
                new PerTokenPricingModel(0.001, 0.003),
                OpenAiModels.PROVIDER,
                LocalDate.of(2025, 1, 1),
                new LegacyOptionsConverter(),
                properties.retryTemplate(GPT_4O_LITE)
        );
    }

    static class LegacyOptionsConverter implements OptionsConverter<OpenAiChatOptions> {

        @NotNull
        @Override
        public OpenAiChatOptions convertOptions(@NotNull LlmOptions options) {
            return OpenAiChatOptions.builder()
                    .topP(options.getTopP())
                    .maxTokens(options.getMaxTokens())
                    .presencePenalty(options.getPresencePenalty())
                    .frequencyPenalty(options.getFrequencyPenalty())
                    .topP(options.getTopP())
                    .build();
        }
    }
}