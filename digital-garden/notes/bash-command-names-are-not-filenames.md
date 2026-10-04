---
title: "A Bash command name is not necessarily a filename"
date: 2026-10-04
lastmod: 2026-10-04
draft: false
tags: ["linux", "bash"]
summary: "Bash resolves bare command names through functions, builtins, and external executable lookup."
status: "growing"
type: "note"
---

Typing a command name does not necessarily identify an executable file. Bash can execute a shell function, invoke one of its builtins, or locate an external program.

For ordinary simple commands in default, non-POSIX Bash, a command name without a slash follows this order:

```text
Shell function
    ↓ if absent
Enabled builtin
    ↓ if absent
External executable lookup
```

The first match wins. Putting a directory first in `PATH` cannot override a function or enabled builtin with the same name.

For example:

```bash
printf() { builtin printf 'function ran\n'; }
printf 'hello\n'
```

The second line invokes the function. Inside that function, `builtin printf` explicitly selects Bash’s builtin.

### A pathname asks a different question

```bash
./tools/demo-tool
```

This supplies a pathname instead of a bare name. Bash selects that path without searching `PATH`; a function named `demo-tool` does not take precedence over it.

Selecting a path does not guarantee that execution succeeds or that the file’s contents remain unchanged.

### Inspect the interpretation first

```bash
type -a demo-tool
```

This lists available interpretations and executable locations. It is an inventory, not an execution trace: an executable appearing in the output does not prove it will run.

For a compact description:

```bash
command -v demo-tool
```

The output is not necessarily a filesystem path. For a function, Bash can print just its name.

Two additional mechanisms explain why the visible command and selected implementation can differ:

- [[Bash aliases replace text before command lookup]] explains how the name reaching lookup can change.
- [[Bash caches executable paths, not programs]] explains why external lookup may skip a fresh directory search.

### Source

[Bash manual: Command Search and Execution](https://www.gnu.org/software/bash/manual/html_node/Command-Search-and-Execution.html) · [Bash Builtin Commands](https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html)
