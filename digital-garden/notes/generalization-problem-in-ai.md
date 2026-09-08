---
title: "Generalization Problem in AI"
date: 2026-09-08
lastmod: 2026-09-08
draft: false
tags: ["ai-safety", "deep-learning", "alignment"]
summary: "We have no theory for how models behave in situations they weren't trained on — and alignment depends entirely on this"
status: "seeding"
type: "note"
---

This is the gap underneath everything else in AI safety.

Generalization means: how does a model behave in situations it didn't see during training? And the honest answer is: we don't really know. We have no satisfactory mathematical theory of generalization for deep learning.

That sounds like a minor academic gap. It's not. It means you can test a model on a million scenarios, it passes every single one, and then on scenario one-million-and-one it does something completely unexpected — and you have *no mathematical framework* to prove that it wouldn't. You can't bound the risk. You can only observe and hope.

This matters much more for systems that are [[Grown Not Designed]]. If you design a system from scratch — write every line of code — you can audit the source. You know what it does because you specified what it does. But a grown system learned its own internal logic through training. You can poke it and observe, but you can't read back the full "reasoning" from the weights any more than you can read a brain by examining neurons.

Here's the punchline: **alignment IS a generalization problem.** When we train a model to be helpful, honest, and harmless, we're training it on specific scenarios. We're teaching values through examples. But what we actually need is for those values to generalize — to hold in situations the model never encountered during training. Novel situations. Adversarial situations. Situations with conflicting principles.

And we can't prove they will, because we have no theory of generalization.

This is what makes [[Value Alignment]] so much harder than [[Goal Alignment]]. You can test goal-following directly. You can't test "behaves ethically in situations nobody imagined yet."

## Source

Pachocki, J. (2026). *An Alien Mind*. OpenAI. [https://openai.com/index/an-alien-mind/](https://openai.com/index/an-alien-mind/)

See also: [[An Alien Mind - Pachocki 2026]]
