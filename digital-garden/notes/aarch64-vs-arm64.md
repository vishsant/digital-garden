---
title: "AArch64 vs ARM64"
date: 2026-09-09
lastmod: 2026-09-09
draft: false
tags: ["linux", "toolchain", "arm", "embedded"]
summary: "Why the same 64-bit ARM architecture has two different names"
status: "seeding"
type: "note"
---

The same 64-bit ARM architecture is called `AArch64` in some places and `arm64` in others. They refer to the same thing — the naming divergence comes from two communities making independent, reasonable choices.

## ARM's naming

When ARM Ltd designed ARMv8 (their 64-bit architecture), they defined two **execution states**:

- **AArch64** — 64-bit execution state. New instruction set, new registers.
- **AArch32** — 32-bit execution state. Backward-compatible with older ARM.

"AArch" stands for **A**RM **Arch**itecture. This is the official terminology in ARM's specs and manuals.

## Linux chose `arm64`

When the 64-bit ARM port was submitted to the Linux kernel in 2012, the directory was named `arch/arm64/` — not `arch/aarch64/`. The kernel already had `arch/arm/` for 32-bit, and `arm64` is the obvious human-readable parallel.

`ARCH=arm64` literally means "use `arch/arm64/`." It's a directory name chosen by a human who preferred plain English over ARM's branding.

## GNU chose `aarch64`

The GNU toolchain (gcc, binutils, glibc) adopted ARM's official name. Toolchains care about spec precision — they need to match the architecture definition exactly. So the [[GNU Target Triplet]] uses `aarch64-linux-gnu-`.

## The 32-bit world didn't split

The 32-bit toolchain and kernel were both built before ARM coined "AArch32," so both use plain `arm`. `ARCH=arm`, `arm-linux-gnueabihf-gcc`. No naming divergence because there was only one name when it was created.

## See also

- [[GNU Target Triplet]]
- [[Cross-Compilation]]
