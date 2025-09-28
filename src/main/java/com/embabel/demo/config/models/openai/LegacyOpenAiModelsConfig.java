package com.embabel.demo.config.models.openai;

import static com.embabel.demo.config.models.LegacyOpenAiModels.GPT_4O;
import static com.embabel.demo.config.models.LegacyOpenAiModels.GPT_4O_MINI;

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
 * <p>
 * Based on LegacyOpenAiModelsConfig in
 * <a href="https://github.com/stevendoolan/embabel-demo/blob/main/src/main/java/com/embabel/demo/config/models/openai/LegacyOpenAiModelsConfig.java">embabel-demo</a>.
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

    /**
     * Legacy model: GPT-4o ("o" for "omni")
     * A model that is good for most tasks.
     * It accepts both text and image inputs, and produces text outputs (including Structured Outputs).
     * Prices from <a href="https://platform.openai.com/docs/models/gpt-4o">platform.openai.com</a>, in USD per 1m tokens.
     */
    @Bean
    public Llm gpt4o() {
        return openAiModelsConfig.openAiCompatibleLlm(
                GPT_4O,
                new PerTokenPricingModel(2.5, 10.0),
                OpenAiModels.PROVIDER,
                LocalDate.of(2024, 8, 6),
                new LegacyOptionsConverter(),
                properties.retryTemplate(GPT_4O)
        );
    }

    /**
     * Legacy model: GPT-4o Mini ("o" for "omni")
     * A fast, affordable small model for focused tasks
     * It accepts both text and image inputs, and produces text outputs (including Structured Outputs).
     * Prices from <a href="https://platform.openai.com/docs/models/gpt-4o-mini">platform.openai.com</a>, in USD per 1m tokens.
     */
    @Bean
    public Llm gpt4oMini() {
        return openAiModelsConfig.openAiCompatibleLlm(
                GPT_4O_MINI,
                new PerTokenPricingModel(0.15, 0.6),
                OpenAiModels.PROVIDER,
                LocalDate.of(2024, 7, 18),
                new LegacyOptionsConverter(),
                properties.retryTemplate(GPT_4O_MINI)
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