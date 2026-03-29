package com.embabel.demo.config;

import com.embabel.agent.mcpserver.sync.McpResourcePublisher;
import com.embabel.agent.mcpserver.sync.SyncResourceSpecificationFactory;
import io.modelcontextprotocol.server.McpServerFeatures;
import java.util.List;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class McpResourceConfig {

    @Bean
    public McpResourcePublisher mcpResourcePublisher() {
        return new McpResourcePublisher() {

            @NotNull
            @Override
            public String infoString(@Nullable Boolean verbose, int indent) {
                return "embabel-demo";
            }

            @NotNull
            @Override
            public List<McpServerFeatures.SyncResourceSpecification> resources() {
                return List.of(
                        SyncResourceSpecificationFactory.staticSyncResourceSpecification(
                                "embabel://demo/info",
                                "demo_info",
                                "Information about the Embabel demo MCP server",
                                "This is an example MCP resource provided by the Embabel demo application.",
                                "text/plain"
                        )
                );
            }
        };
    }
}
