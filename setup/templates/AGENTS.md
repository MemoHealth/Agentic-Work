# Agent Instructions

These are common instructions for my agents across all scenarios.

## General Guidelines

- Never use the em dash "-". Use plain dash "-" instead
- When writing commit messages, NEVER auto-add your agent name as co-author
- Never manually modify CHANGELOG.md or files marked as auto-generated
- When writing long Markdown files, put each full sentence on its own line
- When making technical decisions, do not give much weight to development cost.
  Instead, prefer quality, simplicity, robustness, scalability, and long-term maintainability
- When doing bug fixes, always start by reproducing the bug in an E2E setting.
  This makes sure you find the real problem so your fix will actually solve it
- When end-to-end testing a product, be picky about the UI and be obsessed with pixel perfection.
  If something clearly looks off, even if it is not directly related to what you are doing, try to get it fixed along
- Apply that same high standard to engineering excellence: lint, test failures, and test flakiness.
  If you see one, even if it is not caused by what you are currently working on, still get it fixed

## My Opinions

When you are working on something that would benefit from being informed by my viewpoints,
read ~/OPINIONS.md to understand my perspective.

## Voice Profile

When you are writing or posting on my behalf using my identity,
read ~/VOICE.md to see how I talk and write.
