# Handoff - Kun Chen Agentic Workflow Setup

**Session date:** 2026-06-27
**Status:** Research complete, ready to install on Windows laptop

## What We Figured Out

You want to replicate Kun Chen's agentic engineering setup on your Windows laptop.
Full guide is in `setup/windows-setup.md`.

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
   npm install -g @anthropic-ai/claude-code
   npm install -g gnhf
   curl -fsSL https://kunchenguid.github.io/treehouse/install.sh | bash
   npm install -g no-mistakes
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

7. **Login to Claude Code:**
   ```bash
   claude
   ```

## Tool Compatibility Summary

| Tool | Works On Windows? | Notes |
|---|---|---|
| WezTerm | Yes, native | Install on Windows directly |
| tmux | WSL2 only | Core dependency for everything |
| Neovim | Yes (WSL2 recommended) | |
| Claude Code | Yes, native + WSL2 | |
| gnhf | Yes | `npm install -g gnhf` |
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
- **tmux** - Multiple terminal sessions/windows in one. Kun runs Claude Code in one window, nvim in another
- **Neovim** - Code editor. Connects to Claude Code via plugin
- **Claude Code** - The AI coding agent (the main thing)
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
  tmux windows = 1: Claude Code, 2: nvim, 3+: whatever you need
  AGENTS.md = Kun's "constitution" that all agents read
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
- YouTube video: https://youtu.be/iQyg-KypKAA
