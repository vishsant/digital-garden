---
title: "Cross-Compilation"
date: 2026-09-09
lastmod: 2026-09-09
draft: false
tags: ["linux", "toolchain", "embedded"]
summary: "Building code on one architecture to run on another"
status: "seeding"
type: "note"
---

Cross-compilation is compiling code on one machine (the **host**) to run on a different machine (the **target**). You do this when the target can't compile for itself — an embedded board, a phone, a different CPU architecture.

## How it works in Linux kernel builds

```bash
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
```

Two variables, two jobs:

- **`ARCH=arm64`** — tells the kernel Makefile which architecture-specific source tree to use (`arch/arm64/`). This is a directory picker.
- **`CROSS_COMPILE=aarch64-linux-gnu-`** — a prefix appended to every tool name. The Makefile does `$(CROSS_COMPILE)gcc` → `aarch64-linux-gnu-gcc`, `$(CROSS_COMPILE)ld` → `aarch64-linux-gnu-ld`, etc.

The trailing `-` in `CROSS_COMPILE` is the hint — it's a prefix waiting for a tool name to be appended.

## Why the names differ

`ARCH` uses Linux's name (`arm64`). `CROSS_COMPILE` uses the [[GNU Target Triplet]] (`aarch64-linux-gnu-`). Two naming traditions from two communities meeting in one command.

## See also

- [[GNU Target Triplet]]
- [[AArch64 vs ARM64]]
