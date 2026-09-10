---
title: "Evaluating Skills for Coding Agents"
date: 2026-09-10
lastmod: 2026-09-10
draft: false
tags: ["ai-agents", "skills", "evaluation", "claude-code"]
summary: "A framework for deciding whether a coding agent skill is worth keeping: measure the delta, weigh the cost, test both sides."
status: "seeding"
type: "note"
---

> Sources: [LangChain](https://www.langchain.com/blog/evaluating-skills), [Anthropic](https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents), [OpenAI](https://developers.openai.com/blog/eval-skills), [MindStudio](https://www.mindstudio.ai/blog/build-self-improving-ai-skill-eval-json-claude-code)

## The core truth

All skill content competes for finite context. A skill isn't free — it occupies tokens that could hold conversation history, code, or tool output. Every skill you add has two costs:

1. **Direct cost** — the tokens the skill content occupies when loaded (~1-2k tokens for a 300-line skill).
2. **Selection pressure cost** — more skills means the agent is more likely to pick the wrong one. LangChain found reliable selection at 12 skills; at 20, the agent started misfiring.

## Skills load dynamically, not reliably

Skills use progressive disclosure — the agent reads names and descriptions, then decides which to load. This decision is made by the model, not you. LangChain measured: even with explicit prompts to invoke skills, invocation only reached ~70% on some tasks.

`CLAUDE.md` and `AGENTS.md` load every time — they're the reliable injection point. Put skill invocation guidance there: "when you see task X, use skill Y."

## The keep/drop decision

A skill earns its place only when:

$$\text{delta} \times \text{usage frequency} > \text{context cost} + \text{selection pressure cost}$$

**Delta** is measured across four dimensions:
- **Task completion** — did it finish the job? (LangChain: 82% with skills vs 9% without)
- **Efficiency** — how many turns, tool calls, tokens?
- **Correctness** — did it follow the right conventions?
- **Invocation accuracy** — did it fire when it should, and not fire when it shouldn't?

"The skill works" is not the same as "the skill is worth keeping."

## How to evaluate

### 1. Clean environment
Every run starts from identical state. Docker, a fresh temp directory, or a sandbox. Leftover files from previous runs cause correlated failures that look like skill problems but aren't.

### 2. Task file
10-20 rows per skill. Each row: a prompt, whether the skill `should_trigger` (true/false), and what success looks like. Grow it from real failures you observe.

### 3. Two-lane comparison
For each task, run with skill (treatment) and without (control). Same model, same environment — the skill is the only variable. Without the control, you don't know if the agent succeeded *because of* the skill or *despite* it.

Run **multiple trials** per condition (3-5 minimum). Models are non-deterministic — a single run is an anecdote, not evidence.

### 4. Negative test cases
For every skill, include tasks where it should NOT fire. Good negative cases are **near-misses** — tasks that almost look like the skill's territory but aren't. "Add Tailwind to my existing React app" is a near-miss for a "react-setup" skill. Obviously unrelated tasks (like a Python CSV script) pass trivially and test nothing.

### 5. Graders — two layers
- **Deterministic first**: file exists, test passes, command ran, skill invoked (or didn't). Fast, debuggable, no ambiguity.
- **Rubric-based second** (only when needed): for qualitative things like code style. Use the agent itself as a judge with structured output schema.

Start with deterministic. Add LLM judges only where code genuinely can't capture what you care about.

## Key numbers

| Metric | Value | Source |
|--------|-------|--------|
| Skill selection threshold | ~12 reliable, ~20 breaks down | LangChain |
| Skill invocation rate (with prompting) | ~70% | LangChain |
| Task completion with skills | 82% | LangChain |
| Task completion without skills | 9% | LangChain |
| Recommended starting task count | 20-50 | Anthropic, MindStudio |
| Minimum trials per task | 3-5 | Anthropic |

## Related

Synthesized from four articles on skill evaluation by LangChain, Anthropic, OpenAI, and MindStudio.
