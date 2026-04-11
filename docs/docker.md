[← Previous: Setup](setup.md) | [Back to Index](../README.md) | [Next: Docker Compose →](docker-compose.md)

---

# Docker

## Prerequisites

Set the environment variables for your model provider
(see [Setup](setup.md) for details):

**Anthropic:**

```bash
export ANTHROPIC_BASE_URL=https://<your-private-anthropic-domain>
export ANTHROPIC_API_KEY=<your-api-key>
```

**OpenAI:**

```bash
export OPENAI_BASE_URL=https://<your-private-openai-domain>
export OPENAI_API_KEY=<your-api-key>
```

**Ollama:**
No environment variables required. Docker Desktop provides
`host.docker.internal` which the container uses to reach Ollama
on the host machine.

On Linux (without Docker Desktop), you may need to set
`OLLAMA_HOST=0.0.0.0` so Ollama listens on all interfaces:

```bash
export OLLAMA_HOST=0.0.0.0
ollama serve
```

To make these permanent, add them to your `~/.zshrc` file.
Do not pass API keys directly on the command line as they may be
visible in shell history and process listings.

## Using the scripts

The `docker-run.sh` script pulls the latest image from Docker Hub,
starts the container on port 48080 (4 looks like **e** for Embabel),
and follows the logs. It automatically passes through any provider
environment variables that are set.

| Command                      | Short | Description                   |
|------------------------------|-------|-------------------------------|
| `./docker-run.sh`            |       | Pull the latest image and run |
| `./docker-run.sh --run-only` | `-r`  | Run without pulling           |
| `./docker-run.sh --logs`     | `-l`  | Follow the container logs     |
| `./docker-run.sh --stop`     | `-s`  | Stop and remove the container |

The script detects which provider variables (`ANTHROPIC_BASE_URL`,
`ANTHROPIC_API_KEY`, `OPENAI_BASE_URL`, `OPENAI_API_KEY`) are set in
your environment and passes only those to the container. It also
forwards optional model override variables if set (see
[Overriding the default models](#overriding-the-default-models)).
The container is named `embabel-demo` — restarting the script
automatically removes any existing container with that name.

The service will be available at `http://localhost:48080`.

## Manual fallback commands

If you prefer to run the commands manually, here is what the scripts do
under the hood.

Pull the latest image:

```bash
docker pull stevendoolan/embabel-demo:latest
```

**All providers (Anthropic + OpenAI):**

```bash
docker run -d -p 48080:8080 \
  -e ANTHROPIC_BASE_URL \
  -e ANTHROPIC_API_KEY \
  -e OPENAI_BASE_URL \
  -e OPENAI_API_KEY \
  --name embabel-demo \
  stevendoolan/embabel-demo:latest
```

**Anthropic:**

```bash
docker run -d -p 48080:8080 \
  -e ANTHROPIC_BASE_URL \
  -e ANTHROPIC_API_KEY \
  --name embabel-demo \
  stevendoolan/embabel-demo:latest
```

**OpenAI:**

```bash
docker run -d -p 48080:8080 \
  -e OPENAI_BASE_URL \
  -e OPENAI_API_KEY \
  --name embabel-demo \
  stevendoolan/embabel-demo:latest
```

**Ollama:**

```bash
docker run -d -p 48080:8080 \
  --name embabel-demo \
  stevendoolan/embabel-demo:latest
```

On Linux (without Docker Desktop), add `--add-host=host.docker.internal:host-gateway`
so the container can reach Ollama on the host.

Follow the logs:

```bash
docker logs -f embabel-demo
```

Stop and remove:

```bash
docker rm -f embabel-demo
```

> **Note:** Only pass the `-e` flags for providers you have configured.
> Passing an unset variable with `-e` sends an empty string to the
> container, which may cause the provider client to fail.

## Overriding the default models

The Docker image defaults to `claude-sonnet-4-5` as the default LLM.
You can override the models using environment variables:

```bash
docker run -d -p 48080:8080 \
  -e EMBABEL_MODELS_DEFAULT_LLM=gpt-4.1 \
  -e EMBABEL_MODELS_LLMS_BEST=gpt-4.1 \
  -e EMBABEL_MODELS_LLMS_CHEAPEST=gpt-4.1-mini \
  -e OPENAI_BASE_URL \
  -e OPENAI_API_KEY \
  --name embabel-demo \
  stevendoolan/embabel-demo:latest
```

Available models include:

| Provider  | Models                                 |
|-----------|----------------------------------------|
| Anthropic | `claude-opus-4-1`, `claude-sonnet-4-5` |
| OpenAI    | `gpt-4.1`, `gpt-4.1-mini`             |
| Ollama    | `gpt-oss:20b`, `qwen3:4b`             |

## MCP Server via Docker Hub

When running the Docker image from Docker Hub, the MCP server is available
at `http://localhost:48080/sse`.

> **Note:** The MCP server is unsecured. See [Docker Compose](docker-compose.md)
> for full details.

The following tools are available:

| Tool Name             | Agent                                                   | Description                                                      |
|-----------------------|---------------------------------------------------------|------------------------------------------------------------------|
| `fibonacciNumbers`    | [FibonacciAgent](agents/fibonacci-agent.md)             | Compute Fibonacci numbers using LLM with tool verification       |
| `writeAndReviewStory` | [WriteAndReviewAgent](agents/write-and-review-agent.md) | Generate a story and review it                                   |
| `bestDadJoke`         | [BestDadJokeAgent](agents/best-dad-joke-agent.md)       | Create the best dad joke ever                                    |
| `sonicPiCode`         | [SonicPiAgent](agents/sonic-pi-agent.md)                | Generate Sonic Pi code from user input (not yet working via MCP) |

### Claude Code

Add the MCP server to your global Claude Code config at `~/.claude.json`:

```json
{
  "mcpServers": {
    "embabel-demo": {
      "type": "sse",
      "url": "http://localhost:48080/sse",
      "timeout": 600000
    }
  }
}
```

The 10-minute timeout (600000ms) is recommended because some agents
(e.g. `sonicPiCode`, `writeAndReviewStory`) are long-running.

Alternatively, add via the CLI (note: this does not set the timeout,
so you will need to edit `~/.claude.json` afterwards to add it):

```bash
claude mcp add embabel-demo --transport sse http://localhost:48080/sse
```

### GitHub Copilot

Add a `.vscode/mcp.json` file to your project root:

```json
{
  "servers": {
    "embabel-demo": {
      "type": "sse",
      "url": "http://localhost:48080/sse",
      "timeout": 600000
    }
  }
}
```

### IntelliJ IDEA / JetBrains AI Assistant

Use the SSE URL `http://localhost:48080/sse` when configuring the MCP
server. See [Docker Compose](docker-compose.md) for detailed setup steps.

---

[← Previous: Setup](setup.md) | [Back to Index](../README.md) | [Next: Docker Push →](docker-push.md)
