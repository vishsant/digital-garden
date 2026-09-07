---
title: "Writing Kernel Commit Messages"
date: 2026-09-07
lastmod: 2026-09-07
draft: false
tags: ["linux", "kernel", "writing"]
summary: "A commit message's job is to carry everything the diff cannot. Lead with the problem, not the solution."
status: "seeding"
type: "note"
---

## The core rule

The diff shows *what* changed. The commit message explains *why*.

This is unconditional — it holds for one-line typo fixes, 5000-line features, binding changes, everything.

## The 3-paragraph structure

Kernel maintainers expect this shape:

1. **Problem.** What is wrong or missing *right now*, before the patch? This earns the reviewer's attention.
2. **Impact.** What concretely goes wrong because of this? Who is affected and how? Crashes, missing functionality, inability to describe hardware.
3. **Solution.** What the patch does. This is the only part that overlaps with the diff, and it comes last.

## Finding the right problem level

Ask: **"If this patch never lands, what concretely goes wrong?"** Keep asking until you hit something a reviewer cares about.

Example from a typo fix (`s/recieve/receive/` in a comment):

- *"Fix typo in comment: change 'recieve' to 'receive'."* → Too shallow. Narrates the diff.
- *"Fix misspelling of 'receive' that causes confusion when grepping for receive-path references."* → **Right level.** Names what concretely goes wrong.

## Common mistakes

- **Narrating the diff.** "Add X", "Allow Y", "Update Z" — the diff already says this. The message must say *why*.
- **Describing your journey.** "Based on review feedback..." or "In the earlier posting..." — the reviewer wants to know why the change should exist, not how you got here.
- **Jumping to layer 2.** Explaining a design choice (why *this way*) before establishing why the change is needed *at all*.

## Example

Bad:
```
Fix typo in comment: change "recieve" to "receive"
```

Good:
```
Fix misspelling of "receive" that causes confusion when grepping
for receive-path references
```

## Reference

- [Describe your changes](https://docs.kernel.org/process/submitting-patches.html#describe-your-changes) — the kernel docs section.

Related: [Linux Kernel Development](/notes/linux-kernel-development/)
