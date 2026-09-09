---
title: "Spotting Opportunities in the AI Age"
date: 2026-09-09
lastmod: 2026-09-09
draft: false
tags: ["ai", "strategy", "opportunities", "frameworks"]
summary: "A 5-question checklist for evaluating whether a domain has an extensible-software opportunity, built from the structural logic of the long tail and two collapsing costs."
status: "seeding"
type: "note"
---

## The framework

The opportunity isn't "add AI to things." It's "find where people have unmet niche needs and give them a safe way to extend their tools — with LLMs as the pen, not the product."

## The 5-question checklist

### 1. Where's the long tail?
Find where users complain "I wish it could do X" and the vendor rationally won't build it. Forums, Reddit, support tickets, your own frustrations. The more specific and weird the complaints, the better the signal.

### 2. What are the two costs today?
- Can users currently write their own solution? (Most can't — LLMs step in here)
- Can the platform currently run user code safely? (Most can't — this is what you'd build)

### 3. Which cost is already low?
If the platform already has an extension system (Obsidian plugins, Salesforce Apex), cost #2 is handled but cost #1 might still be high for non-developers. LLMs collapse the remaining cost.

If neither cost is low, you have to solve both — harder, but a bigger moat.

### 4. Who's locked out?
Current extensible tools are almost all local-first developer tools. Entire professions are excluded. If you find a domain full of non-developers with long-tail needs and no safe web-based extension layer — that's wide open.

### 5. What capabilities would you expose?
Think in [[Capability-Based Security]] terms. Not "give them full API access" but "what are the 5–10 narrow actions that let users solve 80% of their niche needs?" This is the product design question.

## The common mistake

Attributing everything to LLMs. "AI is going to let everyone build custom software — that's the whole revolution." What's missing: writing the code is only half. If there's nowhere safe to *run* it, it doesn't matter that an LLM wrote it. Both locks have to open.

When evaluating a pitch or idea, ask: **which cost are they collapsing, and is the other one handled?**

## Related

- [Extensible Software in the AI Age](/notes/extensible-software-in-the-ai-age/)
