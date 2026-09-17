---
title: "Ralph Loops"
date: 2026-09-17
lastmod: 2026-09-17
draft: false
tags: ["ai-agents", "engineering", "process"]
summary: "Fresh-context agent iterations that preserve progress through durable external state."
status: "seeding"
type: "note"
---

Source: https://youtu.be/4DhcSPkEbwI?si=jcNLqGpWlFr5uUqz

A Ralph loop repeatedly gives an agent a goal, asks it to make a small useful change, runs feedback checks, records progress in durable artifacts, clears the context, and starts again from the current state.

The agent does not need to remember the entire conversation. The codebase, tests, tickets, specifications, and other files preserve the state needed for the next iteration.

Ralph loops require a clear goal, useful feedback, durable state, bounded changes, review, and a way to detect completion. They are not permission to run an agent without supervision.

Related: [[Feedback Loops]], [[Tracer Bullets]], [[Strategic Programming]]
