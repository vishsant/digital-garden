---
title: "Bash aliases replace text before command lookup"
date: 2026-10-04
lastmod: 2026-10-04
draft: false
tags: ["linux", "bash"]
summary: "An alias stores replacement text; whether and when Bash applies it is separate from command execution."
status: "growing"
type: "note"
---

An alias is not another implementation competing with functions and executables. It replaces eligible command text while Bash reads input.

Suppose alias expansion is enabled and this definition has already executed:

```bash
alias report='printf'
```

When Bash reads:

```bash
report 'hello\n'
```

Alias replacement produces:

```bash
printf 'hello\n'
```

Bash must still resolve `printf`. If a function named `printf` exists, it takes precedence over the builtin.

The alias stores text—not the implementation available when the alias was defined. This follows the distinction in [[A Bash command name is not necessarily a filename]].

### Defining an alias does not enable its expansion

These operations are separate:

```bash
alias report='printf'      # Store replacement text
shopt -s expand_aliases    # Enable alias expansion
shopt -u expand_aliases    # Disable alias expansion
```

Disabling expansion does not delete stored aliases or prevent new definitions.

If expansion is disabled, `report` remains unchanged and ordinary command lookup proceeds. A stored alias does not reserve the name or block a function or executable named `report`.

Interactive Bash normally expands aliases. Noninteractive Bash does not by default.

### Reading happens before execution

With expansion enabled and no existing alias named `report`:

```bash
alias report='printf'; report 'hello\n'
```

The newly defined alias does not replace the later `report` on this line. Bash reads the whole line before executing either command. During alias expansion, the definition has not executed yet.

Separate top-level lines change the timing:

```bash
alias report='printf'
report 'hello\n'
```

Bash executes the definition before reading the next line, making the alias available.

This is not a universal “newlines fix aliases” rule. Bash reads an entire compound command before executing it; alias definitions inside that construct do not affect its already-read commands.

### Source

[Bash manual: Aliases](https://www.gnu.org/software/bash/manual/html_node/Aliases.html)
