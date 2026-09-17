---
title: "Grill Me"
date: 2026-09-17
lastmod: 2026-09-17
draft: false
tags: ["ai-agents", "alignment", "engineering", "decision-making"]
summary: "An alignment workflow in which an agent interviews the user before implementation."
status: "seeding"
type: "note"
---

Source: https://youtu.be/4DhcSPkEbwI?si=jcNLqGpWlFr5uUqz

Grill Me is an alignment workflow in which an agent interviews the user relentlessly before implementation.

The questions expose hidden decisions about scope, non-goals, permissions, edge cases, limits, failure behavior, trade-offs, terminology, and acceptance criteria.

An agent cannot read the user's mind or infer the complete hierarchy of values. If those values remain implicit, the agent fills the gaps with assumptions. Grill Me is most valuable when mistakes are expensive to reverse, security is involved, or the work will influence future decisions.

> Grill Me converts implicit human judgment into explicit system constraints.

Related: [[Strategic Programming]], [[Feedback Loops]], [[Leading Words]]
