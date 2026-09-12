---
title: "What an Initramfs Does"
date: 2026-09-12
lastmod: 2026-09-12
draft: false
tags: ["linux", "boot", "initramfs"]
summary: "How temporary early userspace prepares Linux to mount its real root filesystem."
status: "growing"
type: "note"
---

An initramfs is a temporary early userspace loaded alongside the kernel.

It contains the tools, scripts, firmware, and modules needed to:

1. Discover the storage device.
2. Load required drivers.
3. Locate the root filesystem.
4. Mount it.
5. Start normal userspace.

The kernel command line commonly identifies the root filesystem:

```text
root=UUID=<filesystem-uuid>
```

The initramfs is not the device tree. The device tree describes hardware; the initramfs helps early Linux userspace access the root filesystem.

After the real root is mounted, normal userspace takes over.
