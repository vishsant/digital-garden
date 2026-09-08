---
title: "Grown Not Designed"
date: 2026-09-08
lastmod: 2026-09-08
draft: false
tags: ["ai-safety", "deep-learning", "scaling"]
summary: "Deep learning AI emerges from massive optimization — like evolution, not engineering — and that's why safety is hard"
status: "seeding"
type: "note"
---

This is the foundational insight of Pachocki's entire essay, and once you get it, everything else follows.

Deep learning AI is not designed. It's *grown*. You take a simple optimization step — nudge these weights to reduce this error — and you repeat it an enormous number of times on massive compute. What comes out the other end works through abstract concepts, simulates human behavior, writes code, reasons about ethics. But nobody designed those capabilities. They *emerged*.

The analogy is evolution. One simple rule — reproduce with variation, select for fitness — repeated over billions of years, producing the staggering complexity of biological life. No designer. No blueprint. No spec. Just a simple process iterated at scale.

This has a profound consequence: you can't guarantee properties by reading a blueprint, because *there is no blueprint*. The model's "logic" lives in billions of learned parameters that nobody wrote and nobody can fully read back. Studying these systems is, as Pachocki puts it, "largely an experimental science" — like neuroscience. You poke the system, observe what happens, form hypotheses, test them. You don't consult documentation.

This single fact is why everything in AI safety is hard. If you could read the source code and verify "yes, this system will always respect human values," the problem would be tractable. But you can't, because there's no source code in any meaningful sense. The system learned its own internal representations, and we're still figuring out how to interpret them.

This is why the [[Generalization Problem in AI]] is so acute for these systems, why the [[Scaling Thesis]] is both exciting and alarming — more compute grows more complex systems we understand even less — and why [[Value Alignment]] requires fundamentally different approaches than traditional software verification.

## Source

Pachocki, J. (2026). *An Alien Mind*. OpenAI. [https://openai.com/index/an-alien-mind/](https://openai.com/index/an-alien-mind/)

See also: [[An Alien Mind - Pachocki 2026]]
