---
title: "Vertical Slices"
date: 2026-09-17
lastmod: 2026-09-17
draft: false
tags: ["engineering", "software-architecture", "process"]
summary: "A narrow feature that crosses the relevant layers of a system."
status: "seeding"
type: "note"
---

Source: https://youtu.be/4DhcSPkEbwI?si=jcNLqGpWlFr5uUqz

A vertical slice is a narrow feature that crosses the relevant layers of a system. In a web application, one slice might include one UI interaction, one API route, one business rule, one database operation, and one visible result.

This contrasts with horizontal implementation, where each layer is built in isolation and integrated later. Horizontal implementation delays the feedback that reveals whether the layers actually fit together.

Vertical slices reduce uncertainty by creating a working path early.

Related: [[Tracer Bullets]], [[Feedback Loops]]
