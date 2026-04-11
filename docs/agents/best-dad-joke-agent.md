# Best Dad Joke Agent

[Previous: Index](index.md) | [Index](index.md) | [Next: Fibonacci Agent](fibonacci-agent.md)

---

**Source:** [`BestDadJokeAgent.java`](../../src/main/java/com/embabel/demo/agent/BestDadJokeAgent.java)

**Description:** Create the best dad joke ever.

**MCP Export:** `bestDadJoke`

Inspired by the [Coffee + Software](https://www.youtube.com/watch?v=kpeYvKha5oE&t=5s) YouTube video by James Ward and Josh Long.

## Configuration

| Property                 | Default | Description                 |
|--------------------------|---------|-----------------------------|
| `bestdadjoke.joke-count` | 5       | Number of jokes to generate |

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
│createBestDadJoke│  ★ AchievesGoal — Select highest-rated joke
└────────┬────────┘
         │
         ▼
  BestDadJokeResult
```

## Actions

| # | Action              | Input             | Output              | Description                                          |
|---|---------------------|-------------------|---------------------|------------------------------------------------------|
| 1 | `writeJokes`        | `UserInput`       | `Jokes`             | Uses LLM to generate N dad jokes based on user input |
| 2 | `rateJokes`         | `Jokes`           | `JokesAndRatings`   | Rates each joke in parallel using LLM                |
| 3 | `createBestDadJoke` | `JokesAndRatings` | `BestDadJokeResult` | Selects the highest-rated joke as the best           |

---

[Previous: Index](index.md) | [Index](index.md) | [Next: Fibonacci Agent](fibonacci-agent.md)
