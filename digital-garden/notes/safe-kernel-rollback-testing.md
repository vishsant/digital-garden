---
title: "Safe Kernel Rollback Testing"
date: 2026-09-12
lastmod: 2026-09-12
draft: false
tags: ["linux", "kernel", "boot", "reliability"]
summary: "How to test a new kernel without losing a known-good recovery path."
status: "growing"
type: "note"
---

A new kernel should be tested beside a known-good kernel, not by replacing it immediately.

```text
known-good kernel + initramfs  ← fallback
new kernel + initramfs         ← test
```

A safe test requires:

1. Versioned kernel files.
2. Matching modules.
3. A matching initramfs.
4. A separate boot entry.
5. A preserved fallback entry.
6. A way to select the fallback without a working display.

Boot selection mechanisms may include a boot menu, serial console, writable EFI variables, or a temporary configuration change.

A successful build is not enough. The real validation is booting the new kernel and confirming its release with `uname -r`.
