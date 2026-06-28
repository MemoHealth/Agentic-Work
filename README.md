# Agentic Work

Setup and resources for replicating Kun Chen's agentic engineering workflow.

## Contents

- `HANDOFF.md` — Where we left off and next steps for your Windows machine
- `setup/windows-setup.md` — Full step-by-step Windows installation guide
- `setup/bootstrap-wsl2.sh` — One script that automates the WSL2-side install
- `setup/dual-agent-strategy.md` — Getting the most from one Claude Pro + one Codex/ChatGPT sub
- `setup/templates/AGENTS.md` — Template for your global agent instructions file
- `setup/templates/OPINIONS.md` — Template for your opinions/preferences file
- `setup/templates/VOICE.md` — Template for your voice/writing style file
- `setup/wezterm.lua` — WezTerm config preconfigured for WSL2
- `setup/skills/` — Agent skills: the `npx skills` CLI, the AXI tools, and ponytail
- `setup/tools/` — Terminal stack guide (WezTerm + tmux + Neovim) with ready-to-use configs

## What This Is

This is Kun Chen's ([@kunchenguid](https://github.com/kunchenguid)) agentic workflow stack adapted for Windows.
Kun is an ex-Meta L8 principal engineer who ships 40+ PRs/day using AI agents.

The stack is agent-neutral: use **Codex** (on a ChatGPT Plus/Pro subscription) and/or **Claude Code**.

Key tools: WezTerm + WSL2 + tmux + Neovim + (Codex / Claude Code) + gnhf + treehouse + firstmate + no-mistakes + AXI tools (gh-axi, chrome-devtools-axi, lavish-axi) + ponytail, installed via the `npx skills` CLI.

Watch the video: https://youtu.be/iQyg-KypKAA
