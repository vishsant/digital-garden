---
title: "Boot Loader Specification Entries"
date: 2026-09-12
lastmod: 2026-09-12
draft: false
tags: ["linux", "boot", "systemd-boot", "uefi"]
summary: "How text entries tell systemd-boot which kernel and initramfs to launch."
status: "growing"
type: "note"
---

A Boot Loader Specification entry is a text file describing how to boot one kernel version.

Typical fields include:

```text
title      Human-readable name
version    Kernel release
options    Kernel command line
linux      Kernel path
initrd     Initramfs path
```

For example:

```text
title  Custom kernel
linux  /<machine-id>/<release>/linux
initrd /<machine-id>/<release>/initrd.img-<release>
options root=UUID=<root-filesystem-uuid>
```

`loader.conf` controls menu behavior and the default entry. A commented timeout can cause systemd-boot to boot the default immediately.

The entry title changes only the displayed label. The filename and `default` setting control selection.
