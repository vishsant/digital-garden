---
title: "Device Trees Describe Hardware"
date: 2026-09-12
lastmod: 2026-09-12
draft: false
tags: ["linux", "device-tree", "embedded"]
summary: "How device-tree data tells Linux about board hardware."
status: "growing"
type: "note"
---

A device tree is data that describes hardware to the Linux kernel.

It can describe:

- CPUs and memory
- UARTs and GPIO controllers
- I2C and SPI buses
- Regulators, clocks, and interrupts
- Connected displays, cameras, and sensors

A compiled device tree is a DTB. A device-tree overlay is a DTBO that modifies or extends a base description.

The kernel uses the device tree together with its driver code:

```text
kernel drivers + device tree data
→ kernel understands this board
```

The device tree is not an executable kernel and does not create a boot entry by itself.
