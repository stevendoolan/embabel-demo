> # Security Warning!
> **This is a Demo project that is publicly available on GitHub!!**
>
> **Public Location: https://github.com/stevendoolan/embabel-demo**
> 
> We use this project to provide the Embabel Engineers with a working example of an Embabel agent when we need help.
> This project is not secure, and should not be used in production. It is provided for educational purposes only.

# About this project
This project is based on the Embabel Java Agent Template, which is available on GitHub.
Please keep this project up to date as java-agent-template is updated.

https://github.com/embabel/java-agent-template

**Table of Contents**
- [Prerequisites](#prerequisites)
- [Choose a Model Provider](#choose-a-model-provider)
  - [OpenAI](#openai)
  - [Private OpenAI](#private-openai)
  - [Ollama](#ollama)
- [Set the System Proxy (if required)](#set-the-system-proxy-if-required)
- [Build and Run the Service](#build-and-run-the-service)
- [MCP Server](#mcp-server)
  - [Claude Code](#claude-code)
  - [JetBrains AI Assistant](#jetbrains-ai-assistant)
- [Updates](#updates)

# How to use this project
## Prerequisites
- Java 21+
- Maven 3.9+
- Git

## Choose a Model Provider
### OpenAI
> **Do not use the public OpenAI as this is not secure!**

To use the OpenAI provider, set the following environment variables:
```bash
export OPENAI_API_KEY=<your-api-key>
```

On Windows, open Windows Settings from the Start Menu, search for "Environment Variables", and add the above variables to your User variables

### Private OpenAI
To use the Private OpenAI provider, set the following environment variables:
```bash
export OPENAI_BASE_URL=https://<your-private-openai-domain>
export OPENAI_API_KEY=<your-api-key>
```

On Windows, open Windows Settings from the Start Menu, search for "Environment Variables", and add the above variables to your User variables

### Private Anthropic
To use the Private Anthropic provider, set the following environment variables:
```bash
export ANTHROPIC_BASE_URL=https://<your-private-openai-domain>
export ANTHROPIC_API_KEY=<your-api-key>
```

On Windows, open Windows Settings from the Start Menu, search for "Environment Variables", and add the above variables to your User variables

## Set the System Proxy (if required)
If you are behind a corporate proxy, you may need to set the system proxy for Java.
You can do this by setting the following environment variables:
```bash
export HTTP_PROXY=http://<proxy-host>:<proxy-port>
export HTTPS_PROXY=http://<proxy-host>:<proxy-port>
export NO_PROXY=localhost,*.example.com
```

On Windows, open Windows Settings from the Start Menu, search for "Environment Variables", and add the above variables to your User variables.

The [ProxyConfigurer](src/main/java/com/embabel/demo/config/ProxyConfigurer.java) class will read these environment variables
and set the system properties for Java and Spring Boot.

### Ollama
Use Ollama to run local models on your machine.  This is free, and the models do work, but they are really slow!

Download Ollama from [ollama.com](https://ollama.com/) and install the gpt-oss model with this command:
```shell
ollama run gpt-oss:20b
```

## Build and Run the Service
By default, the service uses OpenAI and web only.

```shell
mvn spring-boot:run
```

Start the service with OpenAI and shell only:
```bash
mvn spring-boot:run -Popenai,shell
```

Start the service with Anthropic and web only:
```bash
mvn spring-boot:run -Panthropic
```

Start the service with Anthropic and shell only:
```bash
mvn spring-boot:run -Panthropic,shell
```

To use Ollama instead of OpenAI, start Ollama on your laptop and run:
```bash
mvn spring-boot:run -Pollama
```

To use Ollama with shell only, run:
```bash
mvn spring-boot:run -Pollama,shell
```

## MCP Server

> **Warning: The MCP server is currently unsecured.** There is no authentication or authorisation on the SSE endpoint. Do not expose it to untrusted networks. MCP Server Security functionality is expected in Embabel Agent 0.4.0.

This application is also an MCP (Model Context Protocol) server.
When the service is running, all agents with `@Export(remote = true)` are automatically exposed as MCP tools
via an SSE endpoint at `http://localhost:8080/sse`.

The following tools are available:
| Tool Name | Agent | Description |
|---|---|---|
| `fibonacciNumbers` | FibonacciAgent | Compute Fibonacci numbers using LLM with tool verification |
| `writeAndReviewStory` | WriteAndReviewAgent | Generate a story and review it |
| `bestDadJoke` | BestDadJokeAgent | Create the best dad joke ever |
| `sonicPiCode` | SonicPiAgent | Generate Sonic Pi code from user input |

### Claude Code
Start the embabel-demo service, then add it to Claude Code from the terminal:
```bash
claude mcp add embabel-demo --transport sse http://localhost:8080/sse
```

Or add a `.mcp.json` file to your project root:
```json
{
  "mcpServers": {
    "embabel-demo": {
      "type": "sse",
      "url": "http://localhost:8080/sse"
    }
  }
}
```

### JetBrains AI Assistant
Start the embabel-demo service, then in IntelliJ IDEA:
1. Go to **Settings | Tools | AI Assistant | Model Context Protocol (MCP)**
2. Click **Add** (+)
3. Select **SSE** as the connection type
4. Set the URL to `http://localhost:8080/sse`
5. Click **Apply**

Or configure via JSON (**Edit as JSON** button):
```json
{
  "mcpServers": {
    "embabel-demo": {
      "url": "http://localhost:8080/sse"
    }
  }
}
```

---
# Updates
## Update 7 DEC 2025:
Combined Embabel with Sonic Pi by Sam Aaron to create music using AI!

See the new Agent:
- [SonicPiAgent.java](src/main/java/com/embabel/demo/agent/SonicPiAgent.java)

How to use:
1. Install Sonic Pi from https://sonic-pi.net/ - on macOS: `brew install --cask sonic-pi`
2. Start Sonic Pi.
3. Start the Embabel service with Ollama and shell:
   ```bash
   mvn spring-boot:run -Pollama,shell
   ```
4. In the shell, enter the command:
   ```shell
   x "Write a song like Mozart"
   ```
5. There will be two Sonic PI *.rb scripts saved into the `target` directory:
    - `sonic_pi_*.rb` - the generated Sonic Pi melody
    - `sonic_pi-*_with_background_track.rb` - the full song
6. Copy the contents of the `*.rb` files into Sonic Pi and press the "Run" button to play.


## Update 6 DEC 2025: Upgraded to new Embabel Version 0.3.0
This project has been upgraded to use Embabel version 0.3.0, which is now available in Maven Central!

Postman Collection has been created to test the endpoints:
[embabel-demo.postman_collection.json](postman/embabel-demo.postman_collection.json)

Legacy OpenAI Models have been removed as I don't need them anymore (gpt-4o, gpt-4o-lite).

### Fibonacci Agent
Added a Fibonacci Agent as an example of Tool Use:
- [FibonacciAgent.java](src/main/java/com/embabel/demo/agent/FibonacciAgent.java)
- [FibonacciCalculator.java](src/main/java/com/embabel/demo/tool/FibonacciCalculator.java)

How to use the Fibonacci Agent using the REST endpoint:
1. Start the service with OpenAI:
   ```bash
   mvn spring-boot:run -Popenai
   ```

2. Send a GET request: http://localhost:8080/compute-fibonacci?iterations=10

How to use the Fibonacci Agent using the Shell Client:
1. Start the service with OpenAI and shell:
   ```bash
   mvn spring-boot:run -Popenai -Pshell
   ```
   
2. Enter the following command in the shell to compute the 10th Fibonacci number:
   ```shell
   fibonacci
   ```
   
3. To compute any Fibonacci number, replace 10 with your desired number: 
   ```shell
   x "What is the 10th Fibonacci number?"
   ```


## Update 27 SEP 2025: Connects to Private OpenAI

I have got this working with a private OpenAI instance.  I set the following environment variables:
```bash
export OPENAI_BASE_URL=https://<your-private-openai-domain>
export OPENAI_API_KEY=<your-api-key>
```

My API Key only has access to gpt-4o and gpt-4o-lite.
These aren't provided out-of-the-box by Embabel, so I had to implement them myself in
[LegacyOpenAiModels.java](src/main/java/com/embabel/demo/LegacyOpenAiModels.java).
Is there a better way of doing this?

Start the service with OpenAI:
```bash
mvn spring-boot:run -Popenai
```

Start the service with Ollama:
```bash
mvn spring-boot:run -Pollama
```

## Steven's Update 3 SEP 2025: Jasper Blues fixed it!
Thanks very much Jasper Blues for fixing my broken repo!

The problem was the test dependency using 0.1.2-SNAPSHOT.  Removing this fixed the problems listed below.
```xml
        <dependency>
            <groupId>com.embabel.agent</groupId>
            <artifactId>embabel-agent-test</artifactId>
            <!-- This is later than agent version, but will come back in sync in future -->
            <version>0.1.2-SNAPSHOT</version>
            <scope>test</scope>
        </dependency>
```
See Rod Johnson's original commit to fix java-agent-template:
https://github.com/embabel/java-agent-template/commit/488f088f914066b6c3f452d1c69a59e7ceeb89d5

## Steven's Update 2 SEP 2025: I broke it and I don't know how! :(

My first error was:
```
Web application could not be started as there was no
org.springframework.boot.web.servlet.server.ServletWebServerFactory bean defined in the context.
```

I fixed this by adding into [application.properties](src/main/resources/application.properties):
```
spring.main.web-application-type=none
```

Now it won't start, with a new error:
```
Parameter 1 of constructor in 
com.embabel.agent.mcpserver.support.PerGoalMcpToolExportCallbackPublisher 
required a bean of type 'io.modelcontextprotocol.server.McpSyncServer' 
that could not be found.
```

I think it was the refactor where I changed the base package from `com.embabel.template` to `com.embabel.demo`.

I took a fresh template and less refactors. Please see https://github.com/stevendoolan/embabel-demo2