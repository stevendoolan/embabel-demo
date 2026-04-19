# Embabel Demo

Build AI agents on the JVM in minutes with [Embabel](https://github.com/embabel/embabel-agent).

This demo project showcases four agents that demonstrate what Embabel can do:

- **Dad Joke Agent** — generates, rates, and picks the best dad joke
- **Fibonacci Agent** — computes Fibonacci numbers with LLM + tool verification
- **Sonic Pi Agent** — turns natural language into music code
- **Story Agent** — crafts multiple stories, reviews them, and selects the best

### Quick taste

```bash
curl "http://localhost:48080/dad-joke?topic=programming"
```

```json
{
    "bestJoke": {
        "joke": "I would tell you a joke about UDP, but you might not get it!",
        "rating": {
            "score": 4.5
        }
    },
    "otherJokes": [
        {
            "joke": "Why do programmers prefer dark mode? Because light attracts bugs!",
            "rating": {
                "score": 3.5
            }
        }
    ]
}
```

**[Get Started](getting-started.md)** — clone, build, and run your first agent in under 5 minutes.

### Learn more

- [Agent Documentation](docs/agents/index.md) — how each agent works
- [Setup Guide](docs/setup.md) — model providers, proxy config, Maven profiles
- [Docker](docs/docker.md) — pull from Docker Hub or run as an MCP server
- [Docker Compose](docs/docker-compose.md) — build and run locally with Compose
- [Updates](docs/updates.md) — project changelog

---

> **Note:** This is a demo project for educational purposes — not for production use.

Based on [embabel/java-agent-template](https://github.com/embabel/java-agent-template).
