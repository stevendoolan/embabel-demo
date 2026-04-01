# Fibonacci Agent

[Previous: Best Dad Joke Agent](best-dad-joke-agent.md) | [Index](index.md) | [Next: Sonic Pi Agent](sonic-pi-agent.md)

---

**Source:** [`FibonacciAgent.java`](../../src/main/java/com/embabel/demo/agent/FibonacciAgent.java)

**Description:** Compute Fibonacci numbers using LLM and tools, then verify the result.

**MCP Export:** `fibonacciNumbers`

An example of how to combine tools and LLMs in an agent to achieve a goal. The agent computes the Fibonacci number two different ways — once with a tool and once with LLM explanation — then verifies they match.

## Dependencies

- [`FibonacciCalculator`](../../src/main/java/com/embabel/demo/tool/FibonacciCalculator.java) — tool used for verified computation

## Action Flow

```
         UserInput
             │
             ▼
    ┌───────────────────┐
    │toFibonacciRequest │  Extract iteration count from user input
    └────────┬──────────┘
             │
             ▼
      FibonacciRequest
        ┌────┴────┐
        │         │
        ▼         ▼
┌──────────────┐ ┌─────────────────────────┐
│fibonacciWith │ │fibonacciWithExplanation │
│Tool          │ │                         │
└──────┬───────┘ └───────────┬─────────────┘
       │                     │
       ▼                     ▼
FibonacciResponse    FibonacciResponse
  WithTool             WithExplanation
       │                     │
       └──────────┬──────────┘
                  ▼
   ┌──────────────────────────┐
   │fibonacciWithVerification │  ★ AchievesGoal — Compare both results
   └─────────────┬────────────┘
                 ▼
   FibonacciResponseWithVerification
```

## Actions

| # | Action | Input | Output | Description |
|---|--------|-------|--------|-------------|
| 1 | `toFibonacciRequest` | `UserInput` | `FibonacciRequest` | Converts user input into a structured request using LLM |
| 2 | `fibonacciWithTool` | `FibonacciRequest` | `FibonacciResponseWithTool` | Computes Fibonacci using the FibonacciCalculator tool via LLM |
| 3 | `fibonacciWithExplanation` | `FibonacciRequest` | `FibonacciResponseWithExplanation` | Computes Fibonacci with LLM and provides explanation |
| 4 | `fibonacciWithVerification` | `FibonacciResponseWithTool`, `FibonacciResponseWithExplanation` | `FibonacciResponseWithVerification` | Verifies both methods produced the same result |

---

[Previous: Best Dad Joke Agent](best-dad-joke-agent.md) | [Index](index.md) | [Next: Sonic Pi Agent](sonic-pi-agent.md)
