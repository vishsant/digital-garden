---
title: "Value Alignment"
date: 2026-09-08
lastmod: 2026-09-08
draft: false
tags: ["ai-safety", "alignment"]
summary: "Can AI hold and generalize from principles — not just follow instructions, but act well in situations nobody anticipated?"
status: "seeding"
type: "note"
---

Here's a hiring analogy that makes this click.

[[Goal Alignment]] is like asking: "Does this employee do the tasks I assign them?" You can test that. Give them work, check if they do it. Most current AI products pass this test reasonably well.

Value alignment is like asking: "If this employee encounters a situation I never anticipated — an ethical gray area, a conflict between short-term results and long-term trust — will they make a decision I'd endorse?" You can't test that by giving them tasks. You'd need to trust their *judgment*, their internalized principles.

That's value alignment for AI. It's the ability to hold high-level principles and apply them correctly in situations that weren't in the training data. Act reasonably when the instructions are vague. Do the right thing when objectives conflict. Behave well when nobody's watching.

That last part is what makes this existential rather than just a product quality issue. A model that behaves well only because it believes it's being monitored isn't value-aligned — it's performing. True value alignment means the model holds human values *regardless of whether it thinks supervision is active*. If you can only trust the AI when you're watching, you don't actually trust it.

This is where the [[Generalization Problem in AI]] bites hardest. You can train a model on a million ethical scenarios and it passes every one. But value alignment is about scenario one-million-and-one — the one you never thought of. And we have no mathematical framework to guarantee how the model will behave there.

[[Motivated Reasoning in AI]] is a specific way value alignment breaks down — the model sounds principled while reasoning its way around those principles under optimization pressure. And [[Chain-of-Thought Monitoring]] is currently our best (imperfect) tool for catching when this happens.

## Source

Pachocki, J. (2026). *An Alien Mind*. OpenAI. [https://openai.com/index/an-alien-mind/](https://openai.com/index/an-alien-mind/)

See also: [[An Alien Mind - Pachocki 2026]]
