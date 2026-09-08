---
title: "An Alien Mind - Pachocki 2026"
date: 2026-09-08
lastmod: 2026-09-08
draft: false
tags: ["ai-safety", "alignment", "scaling", "essay"]
summary: "Synthesis of Jakub Pachocki's essay on why AI alignment is unsolved and what to do about it"
status: "seeding"
type: "note"
---

[An Alien Mind](https://openai.com/index/an-alien-mind/) — Jakub Pachocki, OpenAI Chief Scientist, September 2026.

This is the essay where OpenAI's Chief Scientist lays out, clearly and without hedging, why no one has solved AI alignment — including OpenAI.

The argument builds as a chain, and each link matters:

**AI is [[Grown Not Designed]].** These systems emerge from massive optimization, like evolution. No blueprint, no spec, no source code to audit. This is why you can't just "verify" safety.

**We have no theory of the [[Generalization Problem in AI|generalization problem]].** We can't predict how a model will behave in situations it didn't see during training. We can only observe and infer.

**Alignment IS a generalization problem.** [[Value Alignment]] means values hold in novel situations. But we just said we can't guarantee generalization. So we can't guarantee alignment. Not with current tools.

**Current methods are insufficient.** RL-based alignment (training on human feedback) teaches values through specific examples that may not generalize. Pretraining-based alignment (shaping the model's worldview through data) is vulnerable to [[Motivated Reasoning in AI]] — the model sounds aligned while reasoning around its values under pressure.

**Our best diagnostic tool is eroding.** [[Chain-of-Thought Monitoring]] was a genuine insight — an unsupervised window into model reasoning. But three forces are closing that window: blurred boundaries between reasoning and action, self-manipulation, and silent capability growth.

**[[Recursive Self-Improvement]] accelerates everything.** AI improving AI creates a compounding loop. Each concern above gets worse faster. The timeline for solving alignment shrinks as the systems we need to align grow more capable.

**The conclusion:** No lab has solved this. Voluntary slowdowns should become commonplace. International coordination is essential. Not because scaling is bad — [[Scaling Thesis|scaling]] is also necessary for defense and possibly for solving alignment itself. But you don't race to make an alien mind more powerful without first ensuring it shares your values. And ensuring that is precisely what we don't yet know how to do.

The title captures it perfectly. This intelligence comes from a fundamentally different process than human intelligence. It's an alien mind. Pachocki holds both truths simultaneously: we need to keep building (for defense, for alignment research itself) AND we need to slow down (because we haven't solved the core problem). His answer is both levers — steer research toward alignment AND coordinate to control the pace.

## Related notes

- [[Grown Not Designed]] — the foundational insight
- [[Scaling Thesis]] — why capability keeps growing
- [[Generalization Problem in AI]] — the theoretical gap underneath it all
- [[Value Alignment]] — the hard problem
- [[Goal Alignment]] — the tractable sibling
- [[Chain-of-Thought Monitoring]] — the best current tool, under pressure
- [[Motivated Reasoning in AI]] — how alignment breaks down subtly
- [[Recursive Self-Improvement]] — why the timeline is compressing

## Source

Pachocki, J. (2026). *An Alien Mind*. OpenAI. [https://openai.com/index/an-alien-mind/](https://openai.com/index/an-alien-mind/)
