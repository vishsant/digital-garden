---
title: "Tracer Bullets"
date: 2026-09-17
lastmod: 2026-09-17
draft: false
tags: ["engineering", "software-architecture", "process"]
summary: "A thin, real implementation that crosses system layers and produces early feedback."
status: "seeding"
type: "note"
---

Source: https://youtu.be/4DhcSPkEbwI?si=jcNLqGpWlFr5uUqz

A tracer bullet is a thin, real implementation that travels through the important layers of a system and produces early feedback.

Instead of completing the database, then the API, then the UI, build one narrow behavior through all three layers. A tracer bullet is end-to-end, functional, narrow, connected to the real system, useful for learning, and suitable as a foundation for later work.

A tracer bullet differs from a disposable prototype. A prototype investigates a focused uncertainty and may be discarded. A tracer bullet is intended to remain part of the system.

Related: [[Feedback Loops]], [[Vertical Slices]], [[Strategic Programming]]
