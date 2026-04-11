# Sonic Pi Agent

[Previous: Fibonacci Agent](fibonacci-agent.md) | [Index](index.md) | [Next: Story Agent](story-agent.md)

---

**Source:** [`SonicPiAgent.java`](../../src/main/java/com/embabel/demo/agent/SonicPiAgent.java)

**Description:** Write Sonic Pi code to play a melody based on user input.

**MCP Export:** Not yet working via MCP Server

Generates a complete Sonic Pi Ruby script by composing melody, harmony, and percussion tracks separately, then combining them. All LLM calls use high temperature (1.0) for creative music generation.

## Dependencies

- [`SonicPiPromptContributor`](../../src/main/java/com/embabel/demo/prompt/persona/SonicPiPromptContributor.java) — provides specialized Sonic Pi knowledge to prompts

## Templates

All prompts use Jinja templates from `resources/templates/sonicpi/`:

| Template                  | Used By                    |
|---------------------------|----------------------------|
| `to-meta-data.jinja`      | `toSonicPiMetadata`        |
| `create-melody.jinja`     | `createMelody`             |
| `add-harmony.jinja`       | `addHarmony`               |
| `add-percussion.jinja`    | `addPercussion`            |
| `combine-all-parts.jinja` | `combineAllSonicPiScripts` |

## Action Flow

```
          UserInput
              │
              ▼
   ┌──────────────────┐
   │toSonicPiMetadata │  Extract musical metadata (style, key, BPM, mood, etc.)
   └────────┬─────────┘
            │
            ▼
      SonicPiMetadata
            │
            ▼
     ┌─────────────┐
     │createMelody │  Generate melody track
     └──────┬──────┘
            │
            ▼
   SonicPiScriptWithMelody
        ┌───┴───┐
        │       │
        ▼       ▼
┌────────────┐ ┌───────────────┐
│addHarmony  │ │addPercussion  │
└─────┬──────┘ └──────┬────────┘
      │               │
      ▼               ▼
SonicPiScript   SonicPiScript
 WithHarmony     WithPercussion
      │               │
      └───────┬───────┘
              ▼
┌──────────────────────────┐
│combineAllSonicPiScripts  │  ★ AchievesGoal — Merge all parts and write file
└────────────┬─────────────┘
             ▼
        SonicPiScript
      (saved to target/)
```

## Actions

| # | Action                     | Input                                                                                                   | Output                        | Description                                                                          |
|---|----------------------------|---------------------------------------------------------------------------------------------------------|-------------------------------|--------------------------------------------------------------------------------------|
| 1 | `toSonicPiMetadata`        | `UserInput`                                                                                             | `SonicPiMetadata`             | Extracts musical metadata: style, title, BPM, mood, key, time signature, instruments |
| 2 | `createMelody`             | `SonicPiMetadata`                                                                                       | `SonicPiScriptWithMelody`     | Generates the melody track                                                           |
| 3 | `addHarmony`               | `SonicPiScriptWithMelody`, `SonicPiMetadata`                                                            | `SonicPiScriptWithHarmony`    | Adds a harmony track to complement the melody                                        |
| 4 | `addPercussion`            | `SonicPiScriptWithMelody`, `SonicPiMetadata`                                                            | `SonicPiScriptWithPercussion` | Adds a percussion/rhythm track                                                       |
| 5 | `combineAllSonicPiScripts` | `SonicPiMetadata`, `SonicPiScriptWithMelody`, `SonicPiScriptWithHarmony`, `SonicPiScriptWithPercussion` | `SonicPiScript`               | Combines all parts into a final script and writes it to the `target/` directory      |

---

[Previous: Fibonacci Agent](fibonacci-agent.md) | [Index](index.md) | [Next: Story Agent](story-agent.md)
