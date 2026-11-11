---
name: issue
description: Work on the repo's issues — pick what's next, shape an issue until it's ready, and implement it by number. Use when the user asks what's next or to work on an issue.
---

# Issue

Light issue workflow for small, single-maintainer projects.

## Setup

- If `.claude/issue.md` exists at the repo root, read it first. It extends this skill (labels, rules, operations) and wins on conflict.
- Use the CLI for the forge hosting `origin`, unless the extension names one. Check `--help` rather than guessing flags.

## Labels

One type and at most one state per issue. Extensions may add labels.

| Label | Kind | Meaning |
|---|---|---|
| `feature` | type | New or improved user-visible behavior |
| `bug` | type | Something is broken |
| `idea` | state | Rough; needs shaping |
| `ready` | state | Specified well enough to build without asking |
| `blocked` | state | Waiting on another issue or decision (say which) |

No state = `idea`. Done = closed.

## Issue shape

A `ready` issue has a "Done when" list concrete enough to check off without asking, and optionally a "Not doing" list. Describe behavior, not implementation.

```markdown
## Why
<1–3 lines>

## Done when
- [ ] <observable, testable criterion>

## Not doing
- <out of scope>   (optional)
```

## Operations

- **Next** — list `ready` first; skip issues whose blocker is still open.
- **Shape #N** — read it and the relevant code, ask focused questions until "Done when" is concrete; show the rewrite and get the user's OK before editing and swapping to `ready`.
- **Work on #N** — shape first if not `ready`; implement against "Done when", respecting "Not doing"; tick the criteria; propose a commit ending `Closes #N`, following the project's commit rules.
