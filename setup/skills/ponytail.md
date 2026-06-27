# Ponytail - "write less code"

A Claude Code skill that makes the agent behave like a lazy senior dev: the best code is the code you never wrote.
By DietrichGebert (not Kun): https://github.com/DietrichGebert/ponytail

## Why it fits Jonathan

Jonathan does not read code, so less code is a direct win: fewer bugs, less to maintain, less surface to trust blindly.
Reported results on real Claude Code sessions: ~54% less code (up to 94%), ~20% cheaper, ~27% faster.
It aligns with OPINIONS.md: simplicity, robustness, and "frameworks should earn their complexity".

## The core idea - "the ladder"

Before writing any code, the agent climbs a ladder of questions and stops at the first one that answers the need:

1. Does this need to exist at all? If no, skip it (YAGNI).
2. Already in this codebase? Reuse it, do not rewrite it.
3. Does the standard library do it? Use it.
4. Native platform feature? Use it.
5. An installed dependency already does it? Use it.
6. One line? Write one line.
7. Only then: the minimum that actually works.

It is lazy about the solution, never about reading the code first, and it never cuts validation, error handling, security, or accessibility.

## Install

It is a Claude Code skill/plugin. Check the repo for the current command, typically:

```bash
# In your project or globally - see the repo README for the exact current command
npx ponytail            # or the documented install/add command
```

Then it auto-injects its ruleset at session start. Confirm by asking Claude "what skills are active".

Repo and install guide: https://github.com/DietrichGebert/ponytail

## How it sits next to AGENTS.md / OPINIONS.md

- AGENTS.md / OPINIONS.md = how Jonathan wants agents to think and decide.
- Ponytail = a focused habit on top: prefer reuse and the minimum code that works.

They reinforce each other. Keep both.
