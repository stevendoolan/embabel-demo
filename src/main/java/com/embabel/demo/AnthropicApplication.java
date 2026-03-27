/*
 * Copyright 2024-2025 Embabel Software, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.embabel.demo;

import com.embabel.demo.config.ProxyConfigurer;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.ConfigurationPropertiesScan;

/**
 * Based on AnthropicApplication in
 * <a href="https://github.com/stevendoolan/embabel-demo/blob/main/src/main/java/com/embabel/demo/AnthropicApplication.java">embabel-demo</a>
 */
@SpringBootApplication
@ConfigurationPropertiesScan("com.embabel.demo")
public class AnthropicApplication {

    public static void main(String[] args) {
        System.setProperty("spring.profiles.active", "anthropic");
        ProxyConfigurer.configureProxy();
        SpringApplication.run(AnthropicApplication.class, args);
    }
}