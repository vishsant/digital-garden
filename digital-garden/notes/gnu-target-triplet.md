---
title: "GNU Target Triplet"
date: 2026-09-09
lastmod: 2026-09-09
draft: false
tags: ["linux", "toolchain", "embedded"]
summary: "The cpu-os-abi naming convention that identifies what a GNU toolchain targets"
status: "seeding"
type: "note"
---

A GNU target triplet is a structured string that describes a complete build target. Despite the name, it often has four parts, but the convention is called a "triplet" for historical reasons.

## Structure

```
aarch64  -  linux  -  gnu
  │           │        │
  CPU         OS     ABI/userland
```

- **CPU** — the processor architecture. Matches the spec name (e.g. ARM Ltd's official `aarch64`, not Linux's `arm64`).
- **OS** — the operating system kernel. `linux`, `none` (bare-metal), `darwin` (macOS), etc.
- **ABI/userland** — the C library and calling conventions. `gnu` (glibc), `musl`, `eabihf` (embedded ABI, hardware float), `android`, `elf` (raw ELF for bare-metal).

## Common triplets

| Architecture | Linux `ARCH=` | GNU triplet (`CROSS_COMPILE=`) | Notes |
|---|---|---|---|
| 64-bit ARM | `arm64` | `aarch64-linux-gnu-` | Naming split: Linux chose readable, GNU chose spec-precise |
| 32-bit ARM | `arm` | `arm-linux-gnueabihf-` | `eabihf` = embedded ABI, hard-float |
| 64-bit x86 (Intel/AMD) | `x86` | `x86_64-linux-gnu-` | Kernel uses `x86` for both 32 and 64-bit |
| 32-bit x86 | `x86` | `i686-linux-gnu-` | `i686` = Pentium Pro era (i = Intel, 686 = P6 family) |
| RISC-V 64-bit | `riscv` | `riscv64-linux-gnu-` | Kernel uses `riscv` for both widths |
| MIPS 64-bit | `mips` | `mips64-linux-gnuabi64-` | Common in routers, network gear |
| PowerPC 64-bit | `powerpc` | `powerpc64-linux-gnu-` | IBM servers, old Macs |
| LoongArch | `loongarch` | `loongarch64-linux-gnu-` | Chinese-designed, relatively new |

The pattern: Linux kernel `ARCH` values tend to be one name covering both 32 and 64-bit (`x86`, `riscv`, `mips`), while GNU triplets encode the exact width (`x86_64` vs `i686`, `riscv64` vs `riscv32`).

## Bare-metal example

`aarch64-none-elf-gcc` — targets 64-bit ARM with no OS (`none`) and raw ELF binary output (`elf`). Used for firmware, bootloaders, embedded code.

## See also

- [[Cross-Compilation]]
- [[AArch64 vs ARM64]]
