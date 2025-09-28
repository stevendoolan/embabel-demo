package com.embabel.demo.config.models;

import com.embabel.agent.config.models.OpenAiModels;

/**
 * Configures extra Open AI models that are not provided out-of-the-box by Embabel.
 * Based on {@link OpenAiModels}.
 * <p>
 * Based on LegacyOpenAiModelsConfig in
 * <a href="https://github.com/stevendoolan/embabel-demo/blob/main/src/main/java/com/embabel/demo/config/models/LegacyOpenAiModels.java">embabel-demo</a>.
 */
public class LegacyOpenAiModels {

    public static final String GPT_4O = "gpt-4o";
    public static final String GPT_4O_MINI = "gpt-4o-mini";

}