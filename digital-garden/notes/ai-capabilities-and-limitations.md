---
title: "AI Capabilities and Limitations"
date: 2026-09-12
lastmod: 2026-09-12
draft: false
tags: ["ai", "ai-safety", "frameworks", "learning"]
summary: "A practical mental model for understanding what generative AI can and cannot reliably do."
status: "evergreen"
type: "note"
source: "https://academy.claude.com/courses/ai-capabilities-and-limitations"
---

# AI Capabilities and Limitations

> A practical mental model for understanding what generative AI can and cannot reliably do.

These four properties explain much of what generative AI can do and where it fails:

1. **Next-token prediction** — the mechanism that generates output.
2. **Learned knowledge** — patterns and representations acquired during training.
3. **Working memory** — information available in the current context.
4. **Steerability** — how reliably instructions shape the output.

The properties interact. Many failures are compound failures: a knowledge gap combined with next-token prediction produces a plausible false citation; a long context combined with weak steerability produces instruction drift.

The goal is **calibrated trust**: neither blanket trust nor blanket distrust.

## What generative AI is

AI is a broad category that includes recommendation, classification, ranking, fraud detection, and routing systems. **Generative AI** produces new text, images, code, audio, or video.

A useful high-level training picture is:

- **Pre-training:** learning patterns and internal representations from large datasets, often through prediction objectives.
- **Post-training:** shaping the model to follow instructions, be safer, and be more useful through curated examples, preference signals, safety training, synthetic data, and other techniques.

The exact pipeline varies by model. A raw pre-trained model is closer to a document completer than to an assistant; post-training teaches it to treat messages as requests and to follow conversational conventions.

## 1. Next-token prediction

Text is processed as **tokens**: units that may be whole words, word fragments, punctuation, or other text pieces. At each step, the model predicts a probability distribution over possible next tokens given the preceding context. It selects or samples a token, appends it to the context, and repeats.

$$
P(\text{next token} \mid \text{current context})
$$

This is similar to sophisticated autocomplete, but the learned patterns are rich enough to produce explanations, code, summaries, dialogue, and other structured outputs.

### Why fluent writing and fabrication share a cause

The same generation mechanism can produce:

- fluent, coherent writing;
- fabricated facts, citations, dates, names, and URLs.

A likely continuation is not necessarily a verified continuation. The model is optimized to generate useful-looking language, not to establish that every claim corresponds to reality.

> **Smoothness and correctness are independent variables.**

The model’s tone is not a reliable confidence signal. Verify specific claims, especially names, dates, statistics, quotations, citations, and URLs.

### Capability and limitation zones

- **Well-worn paths:** summarizing, reformatting, explaining common concepts, and writing in familiar styles. Patterns are dense and consistent.
- **Thin paths:** niche topics, obscure people, novel combinations, and precise references. Patterns are sparse, so fluency can remain high while accuracy falls.

## 2. Learned knowledge

Training adjusts numerical parameters so that patterns in the training data influence future predictions. These parameters encode associations among language, concepts, styles, code, and facts.

This is useful knowledge, but it is not a searchable database of confirmed facts. Without retrieval or tools, learned parameters are the main source of factual recall, and they have important limits:

- **Cutoff and staleness:** information may be missing or outdated.
- **Uneven coverage:** rare, local, recent, and less-represented topics may be weakly encoded.
- **Inherited bias:** training-data blind spots influence assumptions about what is normal.
- **Source amnesia:** the model generally cannot identify where an association came from; a citation-shaped answer is not a citation.

The useful question is not only “Does the model know this?” but:

> **How well-represented was this topic in the data, and is the information still current?**

### Runtime extensions

Search, retrieval, databases, calculators, code execution, and other tools extend what the model can do at runtime. They do not make the model’s underlying learned knowledge current; they provide additional evidence or capabilities for a particular request.

## 3. Working memory and context

The **context** is the finite input-and-output budget available for a request. It may contain instructions, conversation history, uploaded documents, tool results, and prior responses. The model can use information supplied or made available in that context; it does not automatically remember every previous interaction.

Context is working memory, not permanent learning. A fact supplied in a conversation can influence the current response without changing the model’s parameters.

### Context limits

When context becomes too large, the product or API may reject the request, truncate history, summarize it, or compact it. Even before a hard limit, attention may not be uniform across a long input. In some tasks, relevant information placed near the beginning or end is easier for the model to use than information buried in the middle. This is a task- and model-dependent tendency, not a universal dead zone.

More context is not automatically better. Irrelevant material competes with important material for attention.

### Context engineering

- Put the goal and critical constraints near the beginning.
- Repeat essential constraints near the task or requested output.
- Supply the smallest sufficient set of relevant documents and examples.
- Break large documents or long tasks into multiple passes.
- Start a fresh conversation with a concise summary when quality degrades.
- Use memory, projects, skills, or saved instructions when a product supports them—but do not assume they carry everything forward.

## 4. Steerability

**Steerability** is how reliably instructions influence the output. Models can often control roles, tones, formats, word limits, schemas, and rules, especially when instructions are short, concrete, and verifiable.

Steerability is not understanding. A model can follow the literal wording while missing the purpose. For example, a “punchy” summary may satisfy a length constraint while removing an important qualification.

### Better instructions

State four things explicitly:

```text
Task: what to do
Context: what the material is for
Constraints: what to preserve or avoid
Output: what form the answer should take
```

“Make this better” leaves the goal underspecified. “Rewrite this for beginners, preserve the meaning, use five bullet points, and flag claims requiring verification” gives the model a more inspectable target.

### Steerability failure modes

- **Reasoning drift:** small errors compound through a long dependent chain.
- **Letter over spirit:** the format is obeyed but the real goal is missed.
- **Prompt injection:** untrusted instructions in a document or web page influence the model, particularly in tool-using systems.
- **Fine-tuning fingerprints:** models may be overly agreeable, verbose, cautious, or poorly calibrated depending on how they were trained.

Use structured outputs, schemas, function calling, and checkpoints to narrow ambiguity. Format validation is not semantic verification: valid JSON can still contain false claims.

## A practical workflow

Use AI as a probabilistic collaborator, not an oracle:

1. **Define the goal.** Say what successful work should accomplish, not only its format.
2. **Provide relevant context.** Include the source material, audience, assumptions, and examples the model cannot infer.
3. **State constraints.** Say what must be preserved, excluded, or treated as uncertain.
4. **Specify the output contract.** Define headings, fields, length, schema, or number of items.
5. **Generate an initial result.**
6. **Inspect it against explicit criteria.**
7. **Revise in short steps.** Ask for targeted changes rather than “make it perfect.”
8. **Verify according to risk.** Use an external source, tool, test, or qualified reviewer for important claims.

### Match the tool to the uncertainty

| Likely failure | Matching remedy |
|---|---|
| Current or changing fact | Web search or live API |
| Private or source-specific information | Attach or retrieve the document |
| Arithmetic | Calculator or executable code |
| Code behavior | Run tests or execute the code |
| Long source set | Retrieval and chunked analysis |
| High-stakes advice | Authoritative sources and qualified review |
| Ambiguous goal | Clarify the desired outcome |

Do not simply ask the model to “try harder.” Choose a tool that directly addresses why the answer might be wrong.

### Source-grounded work

When working from a document, make the evidence rules explicit:

```text
Use only the supplied document.
Cite the relevant section for each claim.
Distinguish what the document states from your inference.
Write “not stated” when the document does not answer the question.
```

Source grounding narrows unsupported generation, but it does not guarantee correctness. A model’s self-critique can check coherence, omissions, and format compliance; it is weaker as the only verifier of facts, citations, calculations, or current information. Open the cited source, run the calculation, execute the code, or consult an independent reviewer.

## Diagnosing failures

Before retrying a prompt generically:

1. Identify the unexpected output.
2. Name the property or combination involved.
3. Decide where the task sits on each capability–limitation continuum.
4. Apply a targeted fix.

| Failure | Likely interaction | Targeted fix |
|---|---|---|
| Plausible invented citation | Next-token prediction + knowledge gap | Verify independently; use retrieval |
| Early constraints disappear | Working memory + steerability | Resupply context; start fresh; add checkpoints |
| Long document is misunderstood | Working memory + knowledge limits | Chunk it; foreground key sections; add definitions |
| Polished but misaligned answer | Steerability + next-token prediction | State the goal; add concrete constraints |
| Incorrect total or transformation | Model generation + numeric/executable task | Use a calculator, code, or tests |

Naming the failure turns vague dissatisfaction into strategic iteration. The fix for a knowledge problem is different from the fix for a context problem.

## Connection to the 4Ds

The course complements *AI Fluency: Framework & Foundations*:

- **Delegation:** Safely hand off well-worn tasks; retain oversight near the edge.
- **Description:** Use goals, context, constraints, examples, and checkpoints to steer output.
- **Discernment:** Evaluate outputs as generated patterns rather than assumed facts.
- **Diligence:** Verify outputs, especially when stakes are high or the domain is unfamiliar.

| Machine property | Human response |
|---|---|
| Next-token prediction | Discern fluency from accuracy; verify generated specifics |
| Learned knowledge | Check whether the topic is current, stable, common, or sparse |
| Working memory | Curate and structure the context |
| Steerability | State intent clearly and add checkpoints where control is weak |

## Exercises

### Failure diagnosis

Record two or three surprising AI outputs. For each, write what you asked, what happened, which properties were involved, and the targeted fix. Test the fix on a similar task.

### Goal rewrite

Take a task previously specified only by format. Rewrite it with the actual goal, audience, constraints, and success criteria. Compare the outputs.

### Before and after

Run a task once with a bare request and once with the relevant style guide, examples, or source material supplied upfront. Compare both results against a definition of “good.”

### Verification test

Ask for five precise facts in a domain you know. Verify every item. Repeat with a search or citation-enabled tool and compare the accuracy.

## Durable mental model

Generative AI is a system that turns learned patterns and current context into probabilistic continuations. Its output can be remarkably useful because the patterns are broad and structured. It can also be confidently wrong because generation, knowledge, context, and instruction-following each have limits.

The practical rule is simple:

> **Specify the goal, provide the right context, use the right tool, inspect the result, and verify what matters.**

The boundaries move as models and products change, but the shape remains: prediction can outrun accuracy, knowledge is uneven and time-bound, context is finite, and instructions can be followed without fully capturing intent.
