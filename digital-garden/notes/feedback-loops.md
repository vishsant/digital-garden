---
title: "Feedback Loops"
date: 2026-09-17
lastmod: 2026-09-17
draft: false
tags: ["ai-agents", "engineering", "evaluation", "process"]
summary: "Using observed differences between intended and actual behavior to guide the next change."
status: "seeding"
type: "note"
---

Source: https://youtu.be/4DhcSPkEbwI?si=jcNLqGpWlFr5uUqz

A feedback loop compares a system's current behavior with its intended behavior and uses the difference to guide the next change.

A useful loop has an intended outcome, an observable result, a comparison, and a correction or decision. Examples include tests, type checking, code review, user feedback, performance measurements, security checks, and production observability.

Fast iteration is not enough. If the feedback signal is weak or incorrect, an agent can move quickly in the wrong direction. A useful test checks behavior or an invariant independently of the implementation.

> The quality of an agent's output is bounded by the quality of the feedback available to it.

Related: [[Tracer Bullets]], [[Vertical Slices]], [[Strategic Programming]], [[Software Gardening]]
