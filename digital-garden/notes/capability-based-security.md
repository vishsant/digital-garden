---
title: "Capability-Based Security"
date: 2026-09-09
lastmod: 2026-09-09
draft: false
tags: ["security", "software-architecture", "sandboxing"]
summary: "Instead of starting with full access and trying to restrict it (which always leaks), start with nothing and hand over only narrow references to specific actions."
status: "seeding"
type: "note"
---

## The problem with proxies

The obvious approach to running untrusted code safely: put a proxy between user code and the outside world. Give the code a fake token. The proxy intercepts every request, swaps in real credentials, and only allows approved destinations.

This falls apart in practice. To let a script read one specific email, you must:
- Verify the token maps to a "read email" permission
- Check the URL is exactly the right endpoint
- Check the path points to the right email, not a different one
- Strip headers that might leak information
- Keep all this logic updated as the backing API evolves
- Repeat for **every operation on every endpoint**

You're starting with **everything the API can do** and trying to carve away what you don't want. You're playing defense across an enormous surface area. Miss one path, one header, one edge case — security hole. This isn't a staffing or testing problem. It's a **shape** problem: defense across an unbounded surface eventually leaks.

## Flip it: the capability model

Instead of starting with full power and restricting, start with **nothing** and hand over only what you choose:

```js
// Platform defines this:
const getApprovedEmail = () => fetchEmailById(123, realAuthToken);

// Script receives ONLY this:
export default async function(capabilities) {
  const email = await capabilities.getApprovedEmail();
  // No fetch. No tokens. No network. This is ALL it can do.
}
```

The script has no `fetch`, no API key, no network access. It can only call functions you explicitly handed it. **It can't abuse capabilities it doesn't have.**

The key asymmetry: **default-nothing vs. default-everything**. With proxies, the default is everything and you desperately opt out. With capabilities, the default is nothing and you deliberately opt in. Silence is safe.

## WASM is capability-shaped by nature

WebAssembly starts with zero capabilities — no file access, no network, no system calls. The host passes in exactly what it wants the code to have via WASI. The capability model isn't bolted on; it's how the architecture works.

## The IFTTT intuition

IFTTT doesn't give you a Twitter API key — it gives you `twitter.post_new_tweet()`. You don't get a full email client — you get `email.send_me_email`. Narrow references to specific actions. That's the shape.

## Related

- [Extensible Software in the AI Age](/notes/extensible-software-in-the-ai-age/)
