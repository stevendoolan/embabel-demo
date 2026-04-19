[Back to README](README.md)

---

# Getting Started

Get from zero to running AI agents in under 5 minutes.

## Prerequisites

- **Java 21+** — [Download](https://www.azul.com/downloads/#zulu)
- **Maven 3.9+** — [Download](https://maven.apache.org/download.cgi)
- **Git**
- **An API key** — from [OpenAI](https://platform.openai.com/api-keys) or [Anthropic](https://console.anthropic.com/settings/keys)

## Clone and configure

```bash
git clone https://github.com/stevendoolan/embabel-demo.git
cd embabel-demo
```

Set your API key (pick one):

```bash
# OpenAI
export OPENAI_API_KEY=<your-key>

# Anthropic
export ANTHROPIC_API_KEY=<your-key>
```

## Build and run

```bash
mvn spring-boot:run
```

The service starts on `http://localhost:48080`. Once you see `Started DemoApplication`, you're ready.

## Try each agent

### Dad Joke Agent

Generates several dad jokes, rates them, and returns the best one.

```bash
curl "http://localhost:48080/dad-joke?topic=cats"
```

### Fibonacci Agent

Uses an LLM to compute a Fibonacci number, then verifies the result with a tool call.

```bash
curl "http://localhost:48080/compute-fibonacci?iterations=10"
```

### Story Agent

Writes multiple stories, reviews them, and selects the best one.

```bash
curl "http://localhost:48080/story?about=a+brave+robot"
```

### Sonic Pi Agent

Generates Sonic Pi music code from a natural language prompt. This is an async endpoint — submit the job, then poll for the result.

```bash
# Submit the job
curl -X POST "http://localhost:48080/sonic-pi?prompt=play+a+happy+melody"
# Returns: {"jobId": "<id>"}

# Check the result
curl "http://localhost:48080/sonic-pi/<id>"
```

## Next steps

- [Agent Documentation](docs/agents/index.md) — detailed docs for each agent, including action flows and configuration
- [Docker](docs/docker.md) — run from Docker Hub or as an MCP server
- [Setup Guide](docs/setup.md) — alternative model providers (Ollama, private endpoints), proxy configuration, Maven profiles

---

[Back to README](README.md)
