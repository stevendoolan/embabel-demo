# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Stack

Java 21, Spring Boot 3.5, Maven, Embabel agent framework (`com.embabel.agent:embabel-agent-starter` 0.3.4). Server listens on port `48080`.

## Build & run

```bash
mvn spring-boot:run                    # default `all` profile (Anthropic + OpenAI + Ollama)
mvn spring-boot:run -Panthropic        # Anthropic only
mvn spring-boot:run -Popenai           # OpenAI only
mvn spring-boot:run -Pollama           # Ollama (local)
mvn spring-boot:run -Pall,shell        # add Spring Shell REPL
```

Profiles select a config dir under `config/<profile>/` via `spring.config.additional-location`. Default LLM mappings live in those `application.yml` files (e.g. `embabel.models.default-llm`, role aliases `best` and `cheapest`).

API keys: `ANTHROPIC_API_KEY`, `OPENAI_API_KEY` (and optional `*_BASE_URL` for private endpoints). Corporate proxy is read from `HTTP_PROXY` / `HTTPS_PROXY` / `NO_PROXY` by `ProxyConfigurer` before Spring starts.

## Tests

```bash
mvn test                               # unit + non-e2e integration tests
mvn test -Dtest=StoryAgentUnitTest     # single test class
mvn test -Dgroups=e2e                  # e2e tests (require running server on :48080)
```

`maven-surefire-plugin` is configured with `<excludedGroups>e2e</excludedGroups>` — JUnit 5 `@Tag("e2e")` tests are skipped by default. E2E tests in `controller/` and `mcp/` hit `http://localhost:${TEST_PORT:-48080}` and assume the app is already running. Override the port with `-DTEST_PORT=<port>`.

Embabel-aware integration tests extend `EmbabelMockitoIntegrationTest` (from `embabel-agent-test`) and stub LLM calls via `whenCreateObject(...)`. Agents annotated `@Profile("!test")` (Story/DadJoke/Fibonacci) are excluded under the Spring `test` profile so the integration test fixture can register a mocked agent platform.

## Architecture

### Agent flows are GOAP-planned, not hand-wired

Each `@Agent` class in `com.embabel.demo.agent` is a bag of `@Action` methods. Embabel inspects method input/output types and plans an execution chain that reaches the `@AchievesGoal`-annotated terminal action — there is no explicit pipeline wiring. Adding a new `@Action` whose input matches an existing output automatically extends the plan; a missing intermediate type breaks planning at runtime, not compile time.

`@AchievesGoal(export = @Export(remote = true, name = "...", startingInputTypes = {UserInput.class}))` exposes the goal as an MCP tool. The four agents (`DadJokeAgent`, `FibonacciAgent`, `SonicPiAgent`, `StoryAgent`) all start from `UserInput` and are reachable both via REST controllers and as MCP tools (server config in `application.yml` under `spring.ai.mcp.server`).

LLM selection inside an action:
- `context.ai().withAutoLlm()` — default LLM
- `context.ai().withLlm(LlmOptions.withLlmForRole("best"))` — resolved via `embabel.models.llms.best` in the active config

### Sonic Pi agent: multi-step pipeline + few-shot RAG

`SonicPiAgent` chains `metadata → melody → (harmony, percussion, bass in parallel) → combine`. Every action injects two `PromptContributor`s:
- `SonicPiPromptContributor` — bound from the `sonic-pi.*` block in `application.yml` (instructions, allowed instruments, allowed samples). Maintain musical/audio-quality rules there, not in code.
- `SonicPiExamplesContributor` — few-shot examples. Calls `contributionFor(metadata)` which uses an LLM (`prompts/sonicpi/select-matching-examples.jinja`) to pick relevant examples by style/mood/tempo/key, then formats their `.rb` content into the prompt. Falls back to all allowed examples on error.

The example store is a "cheap RAG" (Chux™):
- `SonicPiExampleIndexer` (`@Async @EventListener(ApplicationReadyEvent.class)`) walks `sonic-pi.examples.store-directory` for `.rb` files at startup and on a schedule, calling the LLM (`prompts/sonicpi/extract-example-metadata.jinja`) to derive `SonicPiMetadata` for each new file.
- `SonicPiExampleStore` is an in-memory volatile snapshot persisted to `store.json` (timestamped backup before each save). `storeFile` can be set separately from `storeDirectory` so the JSON lives on a writable volume while the `.rb` files stay read-only (Docker pattern).
- `/sonic-pi` returns HTTP 503 until `indexer.isReady()` — the controller is asynchronous (`POST` returns a `jobId`, `GET /sonic-pi/{jobId}` polls).

The `sonic-pi-examples/` directory is **gitignored** (copyrighted Sonic Pi sample songs). Populate it locally with `./copy-sonic-pi-examples.sh`, which copies from `/Applications/Sonic Pi.app/.../examples` and `~/code/sonicpi`.

### Prompt templates

Jinja templates under `src/main/resources/prompts/{sonicpi,story}/` are referenced by `withTemplate("sonicpi/foo.jinja")`. To change agent behaviour, edit prompts and the `sonic-pi.instructions` block in `application.yml` rather than the Java action code.

## Gotchas

- **Never edit generated `.rb` files** under `docs/sonic-pi/*/` — they are LLM output captured for review. Change prompts or `sonic-pi.instructions` in `config/all/application.yml` (and `src/main/resources/application.yml`) instead.
- `/target` writes Sonic Pi scripts as `target/sonic_pi_script_<timestamp>.rb` (the Spring Boot Maven plugin sets `workingDirectory` to `target`).
- MCP server is `ASYNC` with a 600s request timeout — long Sonic Pi generations rely on this.
- The `all` profile is `activeByDefault` — `mvn spring-boot:run` without `-P` activates it. Combining profiles uses `,` (e.g. `-Panthropic,shell`).
