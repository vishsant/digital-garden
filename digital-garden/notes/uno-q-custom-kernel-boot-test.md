---
title: "UNO Q Custom Kernel Boot Test"
date: 2026-09-12
lastmod: 2026-09-12
draft: false
tags: ["arduino-uno-q", "linux", "kernel", "boot"]
summary: "A field test of a separately installed custom kernel on the Arduino UNO Q."
status: "growing"
type: "note"
---

The UNO Q uses a UEFI and systemd-boot based Linux boot path:

```text
Qualcomm firmware
→ UEFI
→ systemd-boot
→ Linux kernel + initramfs
→ Debian
```

The original Debian kernel was:

```text
7.1.0-ga8333ec56567
```

A custom kernel was built with release:

```text
7.0.0-g122c2c22d838
```

The custom kernel was installed as a separate versioned set containing:

```text
<EFI partition>/<machine-id>/<release>/linux
<EFI partition>/<machine-id>/<release>/initrd.img-<release>
```

A separate [[Boot Loader Specification Entries|Boot Loader Specification entry]] referenced those files and preserved the original Debian entry as fallback. The device already had the required UNO Q [[Device Trees Describe Hardware|device-tree files]] on its EFI partition.

The custom kernel was selected from the systemd-boot menu and booted successfully. The result was confirmed with:

```bash
uname -r
```

which reported:

```text
7.0.0-g122c2c22d838
```

The boot menu was visible over the connected display, and the serial console remained usable.

The default loader configuration was restored after testing, so future boots continue to select the original Debian kernel by default. The custom kernel's modules were installed under its matching release directory as described in [[Kernel Modules Follow the Kernel Release]].

This experiment demonstrates the practical relationship between [[The Linux Boot Chain]], [[What an Initramfs Does]], [[Boot Loader Specification Entries]], [[Device Trees Describe Hardware]], [[Kernel Modules Follow the Kernel Release]], and [[Safe Kernel Rollback Testing]].
