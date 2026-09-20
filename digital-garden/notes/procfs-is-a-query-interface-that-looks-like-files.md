---
title: "Procfs Is a Query Interface That Looks Like Files"
date: 2026-09-17
lastmod: 2026-09-17
draft: false
tags: ["linux", "kernel", "observability", "procfs"]
summary: "Procfs uses the VFS file interface to expose kernel state generated on demand."
status: "growing"
type: "note"
---

Procfs is a kernel-backed filesystem interface. Its entries look like files, but their contents do not need to come from regular files stored on disk.

When a process reads `/proc/<pid>/status`, the path lookup identifies a procfs object and its filesystem operations. The later `read()` call routes into procfs code, which gathers selected information from kernel structures and formats it as text.

The simplified path is:

```text
pathname lookup
  → procfs object
  → read()
  → seq_file
  → proc_pid_status()
  → formatted process state
```

`proc_pid_status()` does not dump the entire `task_struct`. It selects and formats fields such as task state, memory information, signals, capabilities, and context-switch counts.

The `seq_file` interface provides an iterator model, formatting helpers, buffering, and file-position handling. It makes generated kernel output work with ordinary file operations. It does not guarantee a frozen snapshot.

The useful mental model is:

> The kernel implements queries that look like files.

Separate reads from `/proc` are not generally one transaction over system state. They may describe different moments, and access depends on filesystem permissions and security policy.

For example, `/proc/self` resolves for the process performing the lookup. In:

```bash
readlink /proc/self/exe
```

`self` normally refers to the `readlink` process, not the shell that launched it.

Sources:

- [The seq_file Interface](https://docs.kernel.org/filesystems/seq_file.html)
- [`proc_pid_status(5)`](https://man7.org/linux/man-pages/man5/proc_pid_status.5.html)
- [`fs/proc/array.c`](https://github.com/torvalds/linux/blob/master/fs/proc/array.c)
