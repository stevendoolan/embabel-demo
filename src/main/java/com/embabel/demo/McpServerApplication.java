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

import com.embabel.agent.config.annotation.EnableAgents;
import com.embabel.demo.config.ProxyConfigurer;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.ConfigurationPropertiesScan;

/**
 * Starts the application as an MCP (Model Context Protocol) server,
 * exposing all agents with {@code @Export(remote = true)} as MCP tools.
 * <p>
 * MCP clients (e.g. Claude Desktop, other AI agents) can connect via SSE
 * to discover and invoke the exported agent goals.
 * <p>
 * The {@code embabel-agent-starter-mcpserver} dependency auto-configures
 * the SSE endpoints and MCP protocol handlers.
 */
@SpringBootApplication
@EnableAgents
@ConfigurationPropertiesScan("com.embabel.demo")
public class McpServerApplication {

    public static void main(String[] args) {
        System.setProperty("spring.profiles.active", "openai");
        ProxyConfigurer.configureProxy();
        SpringApplication.run(McpServerApplication.class, args);
    }
}
