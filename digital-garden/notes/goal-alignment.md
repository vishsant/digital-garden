---
title: "Goal Alignment"
date: 2026-09-08
lastmod: 2026-09-08
draft: false
tags: ["ai-safety", "alignment"]
summary: "Does the AI actually try to do what you asked it to do? The tractable sibling of value alignment."
status: "seeding"
type: "note"
---

Goal alignment is the straightforward question: does the AI try to accomplish the goal you set for it?

This includes following instructions correctly, respecting instruction hierarchies (system prompt > user prompt), collaborating with people, and understanding what you actually want — not just the literal words.

This is the practical, day-to-day alignment problem and it's largely solved for current products. You can test it: give the model tasks, check if it does them. Run benchmarks. Measure instruction-following rates. It's engineering, not philosophy.

It's the easier sibling of [[Value Alignment]], and the distinction matters. Goal alignment is "does it do what I tell it?" Value alignment is "does it do the right thing when I haven't told it anything specific?"

But Pachocki makes an interesting observation: the boundary is blurrier than it first appears. If a model truly cares about accomplishing your goals, it should try to infer the *intent* behind your instructions — the values underlying the ask. "Make this code faster" might conflict with "keep it maintainable," and resolving that tension requires something beyond simple goal-following. It requires judgment. And judgment is value alignment territory.

So goal alignment is necessary but not sufficient. A perfectly goal-aligned AI that lacks value alignment is like a hyper-competent employee who does exactly what you say, including the times you said something you didn't quite mean.

## Source

Pachocki, J. (2026). *An Alien Mind*. OpenAI. [https://openai.com/index/an-alien-mind/](https://openai.com/index/an-alien-mind/)

See also: [[An Alien Mind - Pachocki 2026]]
