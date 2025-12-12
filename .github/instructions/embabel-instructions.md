# Code Standards for Embabel
---
Embabel (Em-BAY-bel) is a framework for authoring agentic flows on the JVM that seamlessly mix LLM-prompted interactions with code and domain models. 
Supports intelligent path finding towards goals. Integrates with Java and Spring Boot.

## Use secure design patterns for LLM agents

Follow patterns recommended in the paper titled "Design Patterns for Securing LLM Agents against Prompt Injections"
(Kellner LB, Buesser B, Cretu AM et al, https://arxiv.org/abs/2506.08837):
- **Action Selector:** Only provide the tools and MCP required to achieve the Action.
- **Context Minimisation:** Embabel does not keep conversation history, it recreates the prompt each time.
- **Map-then-reduce:** Make many small Actions instead of one big one to achieve a goal.
- **Plan-then-execute:** Embabel separates planning from execution, that's how it works - Goal-Oriented Action Planning (GOAP). 
- **Code-then-execute:** Use Wait For, human in the loop.
- **Dual-LLM pattern:** We can use many models.  Each Action can say which model it needs.

More requirements:
- Avoid handling sensitive data in prompts and actions.
- Validate and sanitise any user inputs before including them in prompts, using JSR-380 (Bean Validation).
- Convert User Input into structured data before using it in further prompts or actions.
  - It is recommended to use an LLM to parse user input into structured data.
- Always define the role of the LLM in the prompt (e.g., "You are a helpful assistant that...").
- Always set the temperature of the LLM to 0.0 for deterministic outputs, unless creativity is explicitly required.
- Always use data structures in prompts instead of free text where possible (e.g., JSON, XML).
- Always use Jinja prompt templating features to avoid injection vulnerabilities.
- Always insert user input into prompts using Jinja variable substitution, never via string concatenation.
  - Always wrap user input with structure to prevent prompt injection:
    ```
    <userinput>
    {{ user_input }}
    </userinput>
    ```
