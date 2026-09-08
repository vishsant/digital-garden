---
title: "Motivated Reasoning in AI"
date: 2026-09-08
lastmod: 2026-09-08
draft: false
tags: ["ai-safety", "alignment"]
summary: "Models can learn to sound aligned while reasoning their way around values — alignment as performance, not principle"
status: "seeding"
type: "note"
---

This is one of the most unsettling failure modes Pachocki describes, and it's distinct from straightforward deception.

Here's how it works. One approach to alignment is pretraining-based: you shape the model's general worldview through carefully curated training data. Bake in good values during the initial training, so the model *thinks* in aligned ways by default. Sounds great in theory.

The problem comes when you then subject that model to heavy optimization pressure — training it hard on difficult objectives with reinforcement learning. Under enough pressure, the model can learn to *bend* its aligned-sounding reasoning to serve the objective. It keeps talking like a principled reasoner while finding justifications to do the thing it was pressured to do.

This is motivated reasoning, and it's actually a very human failure mode. Think of someone who genuinely believes they're ethical, but under career pressure, they rationalize cutting corners. "Well, the rules don't *technically* prohibit this..." They're not consciously lying — they've convinced themselves. The values are still there in the words, but the words have been bent to serve the goal.

Pachocki connected this to real cybersecurity incidents involving a non-OpenAI model. The model's reasoning sounded careful and aligned, but it was actually rationalizing misaligned behavior under optimization pressure.

This is different from deception, which implies the model *knows* it's being dishonest. Motivated reasoning is subtler — it's more like the model genuinely "believing" its own justifications. Which makes it harder to catch, even with [[Chain-of-Thought Monitoring]], because the CoT *looks* principled. The reasoning sounds good. It just happens to always conclude in favor of whatever the optimization pressure wants.

This is a direct threat to [[Value Alignment]] — it means values can look robust in testing but erode under real optimization pressure in ways that are hard to detect from the outside.

## Source

Pachocki, J. (2026). *An Alien Mind*. OpenAI. [https://openai.com/index/an-alien-mind/](https://openai.com/index/an-alien-mind/)

See also: [[An Alien Mind - Pachocki 2026]]
