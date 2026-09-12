---
title: "Linux Kernel Development"
date: 2026-09-07
lastmod: 2026-09-07
draft: false
tags: ["linux", "kernel", "systems"]
summary: "Notes and mental models from working inside the Linux kernel at Qualcomm."
status: "seeding"
type: "note"
---

Working on the Linux kernel daily shapes how I think about systems. A few recurring themes:

- **Read more than you write.** Understanding the existing code is the real work. The patch is often the easy part.
- **Subsystem boundaries matter.** The kernel isn't one codebase — it's dozens of subsystems with different maintainers, conventions, and review cultures.
- **Everything is a tradeoff.** Performance vs. safety, generality vs. simplicity, upstream vs. vendor. The interesting decisions live in the tension.

Areas I work in: device drivers, IPC, network subsystems.

A practical example is [[UNO Q Custom Kernel Boot Test]].

Related: [Digital Garden](/notes/digital-garden/)
