---
title: "The Linux Boot Chain"
date: 2026-09-12
lastmod: 2026-09-12
draft: false
tags: ["linux", "boot", "systems"]
summary: "The stages from firmware to a running Linux userspace."
status: "growing"
type: "note"
---

A Linux system starts through several stages:

```text
Power
→ firmware
→ bootloader or boot manager
→ Linux kernel
→ initramfs
→ root filesystem
→ normal userspace
```

Firmware initializes enough hardware to start the next boot component. The boot manager selects a boot entry. The kernel initializes the system, while the initramfs prepares access to the real root filesystem.

The exact components vary by platform. A board may use UEFI and systemd-boot, U-Boot, or an Android boot image.

See [[Boot Loader Specification Entries]] and [[What an Initramfs Does]].
