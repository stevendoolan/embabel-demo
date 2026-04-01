# Write and Review Agent

[Previous: Sonic Pi Agent](sonic-pi-agent.md) | [Index](index.md) | [Next: Index](index.md)

---

**Source:** [`WriteAndReviewAgent.java`](../../src/main/java/com/embabel/demo/agent/WriteAndReviewAgent.java)

**Description:** Generate stories based on user input, review them, and return the best one.

**MCP Export:** `writeAndReviewStory`

Based on the [java-agent-template WriteAndReviewAgent](https://github.com/embabel/java-agent-template/blob/main/src/main/java/com/embabel/template/agent/WriteAndReviewAgent.java). Uses different LLM roles for writing (best quality, high temperature) and reviewing (cheapest, low temperature), with retry logic for resilience.

## Configuration

| Property          | Default | Description                   |
|-------------------|---------|-------------------------------|
| `storyCount`      | 3       | Number of stories to generate |
| `storyWordCount`  | 500     | Target word count per story   |
| `reviewWordCount` | 100     | Target word count per review  |

## Templates

Prompts use Jinja templates from `resources/templates/story/`:

| Template                      | Used By         | Persona                  |
|-------------------------------|-----------------|--------------------------|
| `craft-story-template.jinja`  | `craftStories`  | `StoryPersonas.WRITER`   |
| `review-story-template.jinja` | `reviewStories` | `StoryPersonas.REVIEWER` |

## Action Flow

```
     UserInput
         │
         ▼
  ┌─────────────┐
  │craftStories │  Generate N stories in parallel (temp 0.8, "best" LLM)
  └──────┬──────┘
         │
         ▼
      Stories
         │
         ▼
  ┌───────────────┐
  │reviewStories  │  Review each story in parallel (temp 0.1, "cheapest" LLM)
  └───────┬───────┘
          │
          ▼
   ReviewedStories
          │
          ▼
  ┌────────────────┐
  │selectBestStory │  ★ AchievesGoal — Pick the highest-rated story
  └───────┬────────┘
          │
          ▼
    ReviewedStory
```

## Actions

| # | Action            | Input                  | Output            | Description                                                                          |
|---|-------------------|------------------------|-------------------|--------------------------------------------------------------------------------------|
| 1 | `craftStories`    | `UserInput`            | `Stories`         | Generates N stories in parallel using the WRITER persona with high temperature (0.8) |
| 2 | `reviewStories`   | `UserInput`, `Stories` | `ReviewedStories` | Reviews each story in parallel using the REVIEWER persona with low temperature (0.1) |
| 3 | `selectBestStory` | `ReviewedStories`      | `ReviewedStory`   | Selects the story with the highest review rating                                     |

## Resilience

All LLM operations include retry logic with up to 3 attempts. Failed operations are logged and skipped, allowing the agent to continue with successfully generated stories.

---

[Previous: Sonic Pi Agent](sonic-pi-agent.md) | [Index](index.md) | [Next: Index](index.md)
