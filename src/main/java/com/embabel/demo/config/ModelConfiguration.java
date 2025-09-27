package com.embabel.demo.config;

import com.embabel.agent.config.models.OpenAiCompatibleModelFactory;
import com.embabel.agent.config.models.OpenAiModels;
import com.embabel.agent.config.models.OpenAiProperties;
import com.embabel.common.ai.model.Llm;
import com.embabel.common.ai.model.LlmOptions;
import com.embabel.common.ai.model.OptionsConverter;
import com.embabel.common.ai.model.PerTokenPricingModel;
import io.micrometer.observation.ObservationRegistry;
import java.time.LocalDate;
import org.jetbrains.annotations.NotNull;
import org.springframework.ai.openai.OpenAiChatOptions;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;

/**
 * Configures extra Open AI models that are not provided out-of-the-box by Embabel.
 * Based on {@link com.embabel.agent.config.models.OpenAiModels}.
 */
@Configuration(proxyBeanMethods = false)
@Profile("openai")
@ConditionalOnProperty("OPENAI_API_KEY")
public class ModelConfiguration extends OpenAiCompatibleModelFactory {

    private static final String GPT_4O = "gpt-4o";
    private static final String GPT_4O_LITE = "gpt-4o-lite";

    private final OpenAiProperties properties;

    public ModelConfiguration(
            @Value("${OPENAI_BASE_URL:}") String baseUrl,
            @Value("${OPENAI_API_KEY}") String apiKey,
            @Value("${OPENAI_COMPLETIONS_PATH:/chat/completions}") String completionsPath,
            @Value("${OPENAI_EMBEDDINGS_PATH:/chat/embeddings}") String embeddingsPath,
            ObservationRegistry observationRegistry,
            OpenAiProperties properties) {
        super(baseUrl, apiKey, completionsPath, embeddingsPath, observationRegistry);
        this.properties = properties;
    }

    @Bean
    public Llm gpt4o() {
        return openAiCompatibleLlm(
                GPT_4O,
                new PerTokenPricingModel(
                        3.0,  // $0.003 per 1K input tokens
                        6.0   // $0.006 per 1K output tokens
                ),
                OpenAiModels.PROVIDER,
                LocalDate.of(2025, 1, 1),
                new DemoOptionsConverter(),
                properties.retryTemplate(GPT_4O)
        );
    }

    @Bean
    public Llm gpt4oLite() {
        return openAiCompatibleLlm(
                GPT_4O_LITE,
                new PerTokenPricingModel(
                        1.0,  // $0.001 per 1K input tokens
                        3.0   // $0.003 per 1K output tokens
                ),
                OpenAiModels.PROVIDER,
                LocalDate.of(2025, 1, 1),
                new DemoOptionsConverter(),
                properties.retryTemplate(GPT_4O_LITE)
        );
    }

    static class DemoOptionsConverter implements OptionsConverter<OpenAiChatOptions> {

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