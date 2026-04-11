# Dad Joke Agent

[Previous: Index](index.md) | [Index](index.md) | [Next: Fibonacci Agent](fibonacci-agent.md)

---

**Source:** [`DadJokeAgent.java`](../../src/main/java/com/embabel/demo/agent/DadJokeAgent.java)

**Description:** Create a dad joke.

**MCP Export:** `dadJoke`

Inspired by the [Coffee + Software](https://www.youtube.com/watch?v=kpeYvKha5oE&t=5s) YouTube video by James Ward and Josh Long.

## Configuration

| Property                 | Default | Description                 |
|--------------------------|---------|-----------------------------|
| `dadjoke.joke-count` | 5       | Number of jokes to generate |

## Action Flow

```
UserInput
    │
    ▼
┌──────────┐
│writeJokes│  Generate N dad jokes from user input
└────┬─────┘
     │
     ▼
  Jokes
     │
     ▼
┌──────────┐
│rateJokes │  Rate each joke in parallel (1–N scale)
└────┬─────┘
     │
     ▼
JokesAndRatings
     │
     ▼
┌─────────────────┐
│createDadJoke│  ★ AchievesGoal — Select highest-rated joke
└────────┬────────┘
         │
         ▼
  DadJokeResult
```

## Actions

| # | Action              | Input             | Output              | Description                                          |
|---|---------------------|-------------------|---------------------|------------------------------------------------------|
| 1 | `writeJokes`        | `UserInput`       | `Jokes`             | Uses LLM to generate N dad jokes based on user input |
| 2 | `rateJokes`         | `Jokes`           | `JokesAndRatings`   | Rates each joke in parallel using LLM                |
| 3 | `createDadJoke` | `JokesAndRatings` | `DadJokeResult` | Selects the highest-rated joke as the best           |

---

[Previous: Index](index.md) | [Index](index.md) | [Next: Fibonacci Agent](fibonacci-agent.md)
