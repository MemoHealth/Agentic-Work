# Handoff - Kun Chen Agentic Workflow Setup

**Session date:** 2026-06-27
**Status:** Research complete, ready to install on Windows laptop

## What We Figured Out

You want to replicate Kun Chen's agentic engineering setup on your Windows laptop.
Full guide is in `setup/windows-setup.md`.

## Your agent: Codex and/or Claude Code

The whole stack is agent-neutral, so you can use either engine (or both):

- **Codex** - runs on your existing **ChatGPT Plus/Pro** subscription. Sign in with your ChatGPT account, no per-token bill. This is your cheapest starting point.
- **Claude Code** - needs a separate Claude Pro/Max subscription or an Anthropic API key.

Kun uses both: Claude for interactive work, Codex for background/overnight runs.
Good news: your `AGENTS.md`, `OPINIONS.md`, and `VOICE.md` are read by **both** agents, so nothing changes there.
gnhf and firstmate both support `claude` and `codex` as targets out of the box.

## Where to run it: laptop vs always-on desktop

- **Start directly on your laptop.** Everything runs locally in WSL2. Simplest, fully enough.
- For **overnight gnhf runs**, keep the laptop plugged in and stop it from sleeping (gnhf has a Windows sleep helper).
- **Later upgrade (Kun's actual setup):** an always-on desktop runs the tmux session 24/7, and you SSH in from laptop or phone (terminal app + `tmux attach`, with Tailscale for easy networking). That is how he checks his agents from his phone. Not needed to begin with.

## Getting started checklist (first session, ~45 min)

- [ ] Run `wsl --install` in PowerShell (admin), restart PC
- [ ] Install WezTerm, copy `setup/wezterm.lua` to `~/.wezterm.lua`
- [ ] Open WezTerm (lands in WSL2), then run the install block in step 3 below
- [ ] Copy the three templates to your home dir (step 4)
- [ ] Install your agent: Codex (ChatGPT login) and/or Claude Code (step 7)
- [ ] Install the skills (step 5)
- [ ] Start `tmux`, launch your agent, say hi
- [ ] (Optional now) voice input + Neovim config

## TL;DR - Do These In Order

1. **WSL2 first** - everything else depends on it
   ```powershell
   wsl --install
   ```
   Restart PC, then continue.

2. **WezTerm** - download from wezterm.org, install on Windows, configure to open WSL2 by default
   - Copy `setup/wezterm.lua` to `~/.wezterm.lua` on your Windows machine

3. **Inside WSL2**, run in order:
   ```bash
   sudo apt update && sudo apt install tmux neovim -y
   curl -fsSL https://fnm.vercel.app/install | bash && source ~/.bashrc
   fnm install --lts && fnm use lts-latest
   npm install -g gnhf
   curl -fsSL https://kunchenguid.github.io/treehouse/install.sh | bash
   npm install -g no-mistakes
   # firstmate: see https://github.com/kunchenguid/firstmate for the current install command
   ```

4. **Copy templates** from `setup/templates/` to your home directory:
   - `AGENTS.md` → `~/AGENTS.md`
   - `OPINIONS.md` → `~/OPINIONS.md`
   - `VOICE.md` → `~/VOICE.md`
   Then fill them in with your actual preferences and writing style.

5. **Install the agent skills** (via Vercel's `npx skills` CLI - see `setup/skills/README.md`):
   ```bash
   npx skills add kunchenguid/gh-axi --skill gh-axi -g
   npx skills add kunchenguid/chrome-devtools-axi --skill chrome-devtools-axi -g
   npx skills add kunchenguid/lavish-axi --skill lavish
   # ponytail: see https://github.com/DietrichGebert/ponytail
   ```

6. **Voice input** - download OpenWhispr (Windows alternative to OpenSuperWhisper):
   https://github.com/OpenWhispr/openwhispr

7. **Install and log in to your agent** (pick one or both):
   ```bash
   # Codex (uses your ChatGPT Plus/Pro subscription)
   npm install -g @openai/codex     # check OpenAI docs for the current package/command
   codex                            # then sign in with your ChatGPT account

   # Claude Code (needs a Claude subscription or Anthropic API key)
   npm install -g @anthropic-ai/claude-code
   claude                           # then log in
   ```

## Tool Compatibility Summary

| Tool | Works On Windows? | Notes |
|---|---|---|
| WezTerm | Yes, native | Install on Windows directly |
| tmux | WSL2 only | Core dependency for everything |
| Neovim | Yes (WSL2 recommended) | |
| Codex | Yes, WSL2 | Runs on your ChatGPT Plus/Pro subscription |
| Claude Code | Yes, native + WSL2 | Needs Claude subscription or Anthropic API key |
| gnhf | Yes | `npm install -g gnhf` - supports codex and claude |
| treehouse | Yes | Cross-platform |
| no-mistakes | Yes | Cross-platform |
| lavish-axi | Yes | Visual HTML planning - `npx skills add kunchenguid/lavish-axi --skill lavish` |
| gh-axi | Yes | Token-efficient GitHub CLI for agents (needs `gh`) |
| chrome-devtools-axi | Yes | Agent-ergonomic browser automation |
| ponytail | Yes | Claude Code skill - makes the agent write less code |
| firstmate | WSL2 only | Depends on tmux + bash |
| OpenSuperWhisper | No - macOS only | Use OpenWhispr instead |

## What Each Tool Does

- **WezTerm** - Terminal emulator, GPU accelerated, cross-platform
- **tmux** - Multiple terminal sessions/windows in one. Run your agent in one window, nvim in another
- **Neovim** - Code editor. Connects to your agent via plugin
- **Codex** - OpenAI's coding agent, runs on your ChatGPT subscription
- **Claude Code** - Anthropic's coding agent (needs a Claude plan or API key)
- **gnhf** ("Good Night Have Fun") - Runs agents overnight. Set a goal, go to sleep, wake up to commits
- **treehouse** - Manages parallel git worktrees so multiple agents can work simultaneously without conflicts
- **firstmate** - Talks to one agent that then orchestrates a crew of parallel agents in tmux windows
- **no-mistakes** - Intercepts git push, runs review/tests/lint before your code reaches the real remote
- **lavish-axi** - Opens agent-generated HTML plans in browser, lets you click elements and give feedback
- **gh-axi** - GitHub CLI rebuilt for agents: cheap, structured output, fewer wasted tokens
- **chrome-devtools-axi** - Browser automation for agents: open pages, click flows, extract, debug
- **npx skills** - Vercel's CLI that installs all the skills above (`npx skills add ...`)
- **AXI** (axi.md) - Design principles for agent-ergonomic CLIs (Kun's own standard - his tools follow it)
- **OpenWhispr** (Windows alt) - Push-to-talk voice dictation, text appears at cursor

## Kun's Workflow Pattern

```
Morning:
  treehouse → get a fresh worktree
  firstmate → dispatch agents to work in parallel on different tasks
  lavish-axi → review/tweak plans visually in browser

Night:
  gnhf "complete the auth system" → agents run overnight
  no-mistakes → validates everything before it goes to remote

Always:
  tmux windows = 1: your agent (codex/claude), 2: nvim, 3+: whatever you need
  AGENTS.md = your "constitution" that all agents read (Codex and Claude both read it)
```

## Links

- Kun's GitHub: https://github.com/kunchenguid
- gnhf: https://github.com/kunchenguid/gnhf
- treehouse: https://github.com/kunchenguid/treehouse
- firstmate: https://github.com/kunchenguid/firstmate
- no-mistakes: https://github.com/kunchenguid/no-mistakes
- lavish-axi: https://github.com/kunchenguid/lavish-axi
- AXI: https://axi.md
- WezTerm: https://wezterm.org
- OpenWhispr (Windows): https://github.com/OpenWhispr/openwhispr
- Codex with ChatGPT plan: https://help.openai.com/en/articles/11369540-using-codex-with-your-chatgpt-plan
- skills CLI: https://github.com/vercel-labs/skills
- YouTube video: https://youtu.be/iQyg-KypKAA
