---
title: "Bash caches executable paths, not programs"
date: 2026-10-04
lastmod: 2026-10-04
draft: false
tags: ["linux", "bash"]
summary: "Bash can reuse a remembered executable pathname instead of searching PATH again."
status: "growing"
type: "note"
---

With command hashing enabled, Bash remembers pathnames found during external executable lookup. Reusing a remembered pathname avoids repeating a `PATH` search.

This happens only after earlier command-resolution stages. As explained in [[A Bash command name is not necessarily a filename]], a function or enabled builtin can take precedence before external lookup is reached.

### An earlier directory does not guarantee a fresh search

Suppose:

```text
PATH=/early:/late:/usr/bin
```

Initially, only `/late/demo-tool` exists. Running `demo-tool` finds it, and Bash remembers that pathname.

Now add `/early/demo-tool`, leaving `PATH` unchanged and the later executable present.

The next invocation can still select `/late/demo-tool`. Directory order has not reversed: Bash reused its cached answer instead of searching again.

The cache holds a pathname, not a copy of the program. Replacing the file at the remembered location does not make Bash retain its old contents.

### Compare the cache with a fresh search

Before changing shell state:

```bash
hash -t demo-tool      # Remembered pathname, if present
type -a -p demo-tool   # Fresh PATH search, ignoring the hash table
```

These can legitimately disagree:

```text
Remembered pathname: /late/demo-tool
Fresh search order:  /early/demo-tool
                     /late/demo-tool
```

The commands answer different questions.

### Clearing the cache changes the next lookup

```bash
hash -r
```

This forgets remembered command locations. The next external lookup can search `PATH` and discover the earlier executable.

A standalone assignment to `PATH` also clears Bash’s remembered locations. Therefore, an experiment demonstrating cache reuse must avoid reassigning `PATH` between invocations.

Clearing the cache does not remove functions or aliases. [[Bash aliases replace text before command lookup]] describes a separate stage that cache clearing does not affect.

### Keep the claim within the experiment

This example assumes hashing is enabled, `PATH` stays unchanged, both executable files remain present, and no alias, function, or builtin takes precedence.

It does not establish behavior after deleting the cached file, nor does it establish the behavior of every shell.

### Sources

[Bash manual: Command Search and Execution](https://www.gnu.org/software/bash/manual/html_node/Command-Search-and-Execution.html) · [Bourne Shell Builtins](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Builtins.html) · [Bash Builtin Commands](https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html)
