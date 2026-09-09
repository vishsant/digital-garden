---
title: "Extensible Software in the AI Age"
date: 2026-09-09
lastmod: 2026-09-09
draft: false
tags: ["software-architecture", "ai", "platforms", "extensibility"]
summary: "Most software leaves a long tail of user needs unmet. Two collapsing costs — writing extensions (LLMs) and running them safely (sandboxing primitives) — are opening a new window for extensible web software."
status: "seeding"
type: "note"
---

> Source: https://jeremymorrell.dev/blog/extensible-software-in-the-age-of-llms/

## The long tail problem

Every piece of software serves a demand curve. The head of the curve — needs most users share — gets built. The long tail — niche, specific, personal needs — stays unserved. Not because developers are lazy, but because **every feature added for a small group makes the product worse for everyone else**. There's a complexity ceiling, and developers rationally stop before hitting it.

This long tail has always existed. What's new is that the two costs keeping it locked are collapsing at the same time.

## Two costs lock the long tail

| Cost | What collapsed it | When |
|------|------------------|------|
| **Writing extensions** | LLMs — anyone can describe what they want and get working code | ~2023–now |
| **Running them safely** | Sandboxing primitives — V8 isolates, WASM, microVMs | ~2018–now |

These are **independent problems with independent solutions**. LLMs didn't make sandboxing possible. Google, Mozilla, Cloudflare, and the WebAssembly community did that over a decade of infrastructure work. LLMs collapse the *authoring* cost. The infrastructure collapses the *execution* cost. Both being low at the same time is what creates the window.

## Why running untrusted code is hard

Every capability you give user code is a capability it can abuse:
- Network access → exfiltration (leak API keys to a third party)
- Memory access → snooping on other users (Spectre-class attacks)
- CPU access → denial of service (infinite loops, crypto mining)
- Credentials + fetch → game over (send secrets anywhere)

The solution isn't one problem — it's that every useful capability opens a new attack surface. This is why [[Capability-Based Security]] matters.

## The infrastructure menu (2026)

| Primitive | What it is | Cold start | Overhead |
|-----------|-----------|------------|----------|
| Interpreter (Lua, QuickJS) | Embed a lightweight runtime | Instant | Tiny |
| V8 Isolates | Chrome's JS engine, battle-hardened | ~ms | Small |
| MicroVMs (Firecracker) | Stripped-down virtual machines | <1s | Medium |
| WASM + WASI | Bytecode, zero capabilities by default | ~ms | Small |

Salesforce had to build their own language (Apex) in 2007 because none of this existed. In 2026, you pick one off the shelf and focus on your product.

## The opportunity

Most existing software hasn't adapted. Users can now speak code into existence, but most platforms can't leverage that. Current extensible tools (Pi, opencode, Deepseek) are all local-first developer tools — they lock out non-developers.

**The web is the unlock.** A web-based extensible platform means anyone — accountant, doctor, support agent — can use it without installing anything.

The opportunity is not "build another AI tool." It's: find a domain where users have unmet long-tail needs, give them a safely extensible platform, and let LLMs be the authoring layer. The product is the platform + the trust boundary. The LLM is just the pen.

## Related

- [Capability-Based Security](/notes/capability-based-security/)
- [Spotting Opportunities in the AI Age](/notes/spotting-opportunities-in-the-ai-age/)
