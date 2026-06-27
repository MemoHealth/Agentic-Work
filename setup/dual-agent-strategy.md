# Running both: Claude Pro ($20) + ChatGPT Plus / Codex ($20)

Two $20 subscriptions is a strong setup. The point is not just "more model" - it is two independent rate-limit pools you can run at the same time. When one hits its limit, the other keeps going.

## Division of labor (recommended for Jonathan)

You work at the big-picture and UX level and do not read code. Play to each engine's strength:

- **Claude Code = the cockpit (interactive).**
  Planning, talking through ideas, UX and design discussions, reviewing summaries, driving lavish HTML plans. Claude is pleasant for back-and-forth interactive work, which is where your judgment lives.

- **Codex = the workhorse (background).**
  Overnight `gnhf` runs, parallel `firstmate` crews, bug-finding, mechanical execution. Kun's own view (in OPINIONS.md): GPT/Codex is strong for non-interactive background execution.

Both read the same `AGENTS.md`, `OPINIONS.md`, and `VOICE.md`, so the two agents behave like the same "you" with two sets of hands.

## How to actually run them in parallel

1. Use `treehouse` to give each agent its own isolated worktree - no conflicts.
2. In tmux: window 1 = Claude (interactive), window 2 = Codex (background task), window 3+ = more agents via `firstmate`.
3. Point `gnhf` at whichever agent has budget left tonight (`gnhf` supports both `claude` and `codex`).
4. Hand interactive/UX tasks to Claude, hand long autonomous tasks to Codex. They run at the same time on separate limits.

## Managing the limits (the $20 reality)

- $20 tiers are real but modest. Heavy parallel + overnight work can exhaust both.
- **Claude Pro:** usage resets on rolling windows (roughly every few hours) plus a weekly cap.
- **ChatGPT Plus / Codex:** weekly usage cap. Check remaining mid-session with `/status` inside Codex.
- **Stagger heavy work** so you are not slamming both ceilings at once. Run the big overnight job on one engine, keep the other fresh for daytime interactive work.
- **Stretch both further** with the token-savers already in this repo: AXI tools (~40% less output via TOON) and ponytail (less code written).

## When to upgrade (and which one)

Start with 2 x $20 and watch where you actually get blocked:

- Constantly rate-limited during **interactive** work -> upgrade Claude (Max).
- Constantly rate-limited on **overnight / parallel background** runs -> upgrade Codex (Pro 5x/20x).

Let real usage decide. Do not pre-pay for capacity you have not hit yet.

## Links

- Codex with ChatGPT plan: https://help.openai.com/en/articles/11369540-using-codex-with-your-chatgpt-plan
- Claude plans: https://claude.ai/upgrade
