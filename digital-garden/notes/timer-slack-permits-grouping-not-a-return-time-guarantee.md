---
title: "Timer slack permits grouping, not a return-time guarantee"
date: 2026-10-11
lastmod: 2026-10-11
draft: false
tags: ["linux", "kernel", "systems"]
summary: "Timer slack permits grouping nearby expirations; it does not bound when a sleeping thread executes again."
status: "growing"
type: "note"
---

A thread’s sleep timer becoming due and that thread executing again are separate events. Timer slack affects the timer side of that sequence.

For an ordinary, non-realtime thread, Linux can use timer slack to group nearby timer expirations. This reduces separate CPU wakeups and can save power.

## A 10 ms and 11 ms example

Suppose two timers are due at **10 ms** and **11 ms**.

If the first timer allows **1 ms of slack**, Linux can group both expirations at **11 ms**. It need not use the entire allowance every time: slack permits a delay rather than requiring one.

That allowance does not permit moving the first timer earlier than its requested expiry.

## Why 11 ms is not a return deadline

The grouping window does not guarantee that the timer callback executes by its end. Delays in servicing the timer can affect when the thread is awakened.

After wakeup, the thread still needs to be scheduled onto a CPU before its sleep call can finish returning.

Consequently, a 10 ms sleep with 1 ms of slack can return later than 11 ms. That observation alone does not prove the kernel exceeded the timer-grouping allowance.

## What a measurement can establish

If a requested 10 ms sleep returns successfully after 14 ms, the measurement establishes the elapsed duration. It does not separate delayed timer handling from scheduling delay after wakeup.

Reducing timer slack changes the permitted grouping allowance. It does not reserve CPU time for the thread.

## Sources

- [PR_SET_TIMERSLACK(2const)](https://man7.org/linux/man-pages/man2/PR_SET_TIMERSLACK.2const.html): grouping purpose, affected waits, and realtime-policy exemption.
- [nanosleep(2), NOTES](https://man7.org/linux/man-pages/man2/nanosleep.2.html#NOTES): possible delay before the calling thread executes again.
