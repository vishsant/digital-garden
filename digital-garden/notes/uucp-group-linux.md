---
title: "The uucp Group in Linux"
date: 2026-09-08
lastmod: 2026-09-08
draft: false
tags: ["linux", "history", "serial"]
summary: "Why /etc/group still has a uucp entry — a fossil from 1970s store-and-forward networking that now just means serial port access."
status: "seeding"
type: "note"
---

## What is UUCP?

UUCP = Unix-to-Unix Copy Program. A system from the 1970s-80s for transferring files and email between Unix machines over serial lines (modems, direct cables).

## How it worked

Before the internet was widespread, most Unix machines weren't networked. UUCP solved this with a store-and-forward model over phone lines:

1. Machine A queues up outgoing mail and files
2. At a scheduled time (often late at night when phone rates were cheap), Machine A's modem dials Machine B's modem
3. They authenticate, exchange queued data in both directions, and hang up
4. If mail is destined for Machine C, Machine B holds it until its next scheduled call to Machine C and passes it along

Email addresses used **bang path** addressing: `machineA!machineB!machineC!user` — you literally spelled out the relay chain. This is why `!` has special history in Unix.

Usenet news propagated the same way — each machine called its neighbors, exchanged new posts, and those neighbors passed them further. A post could take days to reach the whole network.

## Why the group still exists

The UUCP daemon needed exclusive access to serial ports (`/dev/ttyS0`, etc.) to dial out, so those devices were owned by group `uucp`. Only processes in that group could open the port.

Serial ports today (`/dev/ttyUSB*`, `/dev/ttyS*`, `/dev/ttyACM*`) are direct descendants of those old modem lines. Arch Linux kept `uucp` as the owner group for all serial devices. Nobody runs actual UUCP anymore — the group just means "users allowed to talk to serial hardware."

## uucp vs dialout

Different distros chose different group names for the same purpose:

- **Arch, Fedora, SUSE** → `uucp` (named after the original program)
- **Debian, Ubuntu** → `dialout` (named after the action — dialing out on a modem)

Same concept, different name, same 1970s modem heritage.

## Why UUCP died

Once TCP/IP and the internet became common in the early-mid 1990s, there was no reason to batch-relay mail over phone calls. SMTP delivered email in seconds. Usenet switched to NNTP. UUCP lingered in remote areas into the 2000s but is essentially extinct now.

The group name is the last visible trace of it in a modern Linux system — a fossil in `/etc/group`.

## Practical takeaway

To access serial port of devices (like [Arduino UNO Q](https://docs.arduino.cc/hardware/uno-q/)) on Arch-based distros (e.g. Omarchy) , you need to be in the uucp group.

```bash
sudo usermod -aG uucp $USER
# then log out and back in
```

## Related

- [Linux Kernel Development](/notes/linux-kernel-development/)
