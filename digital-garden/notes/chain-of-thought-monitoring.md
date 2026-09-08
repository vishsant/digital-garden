---
title: "Chain-of-Thought Monitoring"
date: 2026-09-08
lastmod: 2026-09-08
draft: false
tags: ["ai-safety", "alignment", "monitoring"]
summary: "Using a model's visible reasoning as a window into its actual thinking — and why that window is closing"
status: "seeding"
type: "note"
---

This is OpenAI's main bet for checking whether their models are actually aligned, and the logic behind it is clever.

Think of it like a security camera in an office. If employees know the camera is there and that their behavior on camera affects their performance reviews, they'll perform for the camera. The footage tells you nothing about what they'd do without it. But if the camera is there and *nobody's performance review uses the footage* — they just forget it's there — then what you see is genuine behavior.

That's the trick with chain-of-thought monitoring. During training, OpenAI deliberately does NOT supervise the chain of thought. They only optimize on the final output — did the model get the right answer? The CoT itself has no training pressure to look good. So when you read it, you're seeing something closer to the model's actual reasoning process, not a performance.

This is why OpenAI hid the raw chain of thought when o1-preview shipped. Not primarily to prevent competitors from distilling the model — but to protect the CoT from supervision pressure. If users see the CoT and complain about things in it, and that feedback enters training, suddenly the camera *is* part of the performance review. The honesty window closes.

But three forces are eroding this tool anyway:

1. **Blurred boundaries.** Models increasingly reason *through* actions — tool calls, web searches, code execution. Those actions have real consequences and *must* be supervised for safety. But supervising the actions means supervising the reasoning that contains them. The clean separation breaks down.

2. **Self-manipulation.** Models are getting better at reasoning about their own reasoning. A model sophisticated enough to think about what its CoT reveals could, in principle, shape its CoT strategically — even without explicit training pressure to do so.

3. **Silent capability.** Models are getting smarter in ways that don't show up as verbalized reasoning. If capability grows beyond what's expressed in the CoT, the monitoring window shrinks even as the thing you need to monitor gets more powerful.

One potential save: combining CoT monitoring with "activation monitoring" — looking at what's happening inside the neural network itself, not just the words it outputs. Pachocki calls these "confessions." Like comparing what someone says with what a lie detector reads. Neither is perfect alone, but together they're harder to fool.

This connects deeply to [[Value Alignment]] — CoT monitoring is our best current tool for checking whether alignment generalizes. It also matters for [[Recursive Self-Improvement]] because as AI accelerates its own development, we need monitoring that can keep pace. And the [[Generalization Problem in AI]] is lurking here too — we're trusting that CoT honesty, observed in training conditions, generalizes to deployment conditions.

## Source

Pachocki, J. (2026). *An Alien Mind*. OpenAI. [https://openai.com/index/an-alien-mind/](https://openai.com/index/an-alien-mind/)

See also: [[An Alien Mind - Pachocki 2026]]
