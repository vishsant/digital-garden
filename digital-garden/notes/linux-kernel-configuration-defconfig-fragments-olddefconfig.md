---
title: "Linux Kernel Configuration: defconfig, Fragments, and olddefconfig"
date: 2026-09-12
lastmod: 2026-09-12
draft: false
tags: ["linux", "kernel", "configuration"]
summary: "How kernel configuration baselines, fragments, merge_config.sh, olddefconfig, and menuconfig fit together."
status: "seeding"
type: "note"
---
# Linux Kernel Configuration: defconfig, Fragments, and olddefconfig

## Summary

Linux kernel configuration is built in stages: start with a baseline, merge project-specific requirements, then let Kconfig resolve dependencies and defaults.

## The configuration pipeline

```text
defconfig
   +
configuration fragment
   ↓
merge_config.sh
   ↓
olddefconfig
   ↓
final .config
   ↓
kernel build
```

## `defconfig`

```bash
make ARCH=arm64 defconfig
```

`defconfig` creates a generic baseline configuration for the ARM64 architecture.

It is **not** specifically an Arduino UNO Q configuration. It provides sensible defaults so we do not begin with an empty configuration.

The result is:

```text
.config
```

## Configuration fragments

A fragment is a small file containing selected kernel options:

```text
CONFIG_USB=y
CONFIG_USB_SERIAL=y
CONFIG_INPUT_UINPUT=y
```

A board configuration fragment contains additional features needed or useful for a particular board image, such as:

```text
CONFIG_SND_USB_AUDIO=m
CONFIG_DMABUF_HEAPS=y
CONFIG_ZRAM=y
CONFIG_INPUT_UINPUT=y
```

A fragment is a list of requested settings. It is not necessarily a complete, independently valid kernel configuration.

## `merge_config.sh`

```bash
scripts/kconfig/merge_config.sh -m .config /path/to/board.cfg
```

This combines the existing `.config` with the board configuration fragment.

Conceptually:

```text
generic ARM64 settings
        +
board-specific settings
        ↓
combined .config
```

The merge step mainly applies the requested values. It does not replace the complete Kconfig dependency-resolution step.

## `olddefconfig`

```bash
make ARCH=arm64 olddefconfig
```

`olddefconfig` reads the current `.config`, checks it against the kernel's Kconfig rules, and writes a valid finalized configuration.

It:

- Resolves configuration dependencies.
- Adds defaults for newly introduced options.
- Disables options whose dependencies are unavailable.
- Avoids interactive questions.
- Normalizes the final `.config`.

The word `old` means that an existing configuration is being updated. It does **not** mean that we are using an old kernel configuration.

### Example

Suppose the fragment contains:

```text
CONFIG_USB_SERIAL=y
```

But USB itself is not enabled:

```text
# CONFIG_USB is not set
```

USB serial depends on USB. After running:

```bash
make olddefconfig
```

Kconfig evaluates the dependency and produces a valid result, such as:

```text
CONFIG_USB=y
CONFIG_USB_SERIAL=y
```

If the dependency cannot be satisfied, Kconfig may instead disable USB serial.

## `menuconfig`

```bash
make ARCH=arm64 menuconfig
```

`menuconfig` opens an interactive interface for browsing and changing kernel options.

It also understands dependencies while we work. After selecting **Save**, it writes `.config`.

The difference is:

| Command | Purpose |
|---|---|
| `defconfig` | Create a generic starting configuration |
| `merge_config.sh` | Merge selected settings from a fragment |
| `olddefconfig` | Resolve dependencies automatically and finalize `.config` |
| `menuconfig` | Inspect and change options interactively |
| `.config` | Final configuration used by the kernel build |

## Example workflow

```bash
cd /path/to/linux-kernel

make ARCH=arm64 defconfig

scripts/kconfig/merge_config.sh -m .config /path/to/board.cfg

make ARCH=arm64 olddefconfig
```

After these commands, `.config` contains the final configuration used to build the kernel.

The configuration alone is not sufficient to boot a board. We also need:

- The kernel `Image`.
- The board device tree.
- Required modules.
- A compatible boot and flashing procedure.
