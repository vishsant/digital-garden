---
title: "Kernel Modules Follow the Kernel Release"
date: 2026-09-12
lastmod: 2026-09-12
draft: false
tags: ["linux", "kernel", "modules"]
summary: "Why kernel modules, dependency metadata, and initramfs contents must match a kernel release."
status: "growing"
type: "note"
---

Kernel modules are installed under a directory named after the kernel release:

```text
/lib/modules/<kernel-release>/
```

The release is reported by:

```bash
uname -r
```

After installing modules, dependency metadata must be generated:

```bash
depmod -a <kernel-release>
```

The initramfs should be generated from the same module tree. A kernel, its modules, and its initramfs should be treated as one versioned set.

Installing modules under the wrong release directory can prevent `modprobe` and the initramfs from finding compatible modules.
