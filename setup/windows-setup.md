# Kun Chen's Agentic Workflow - Windows Setup Guide

Full step-by-step guide to replicate Kun Chen's setup on Windows.
Reference: https://youtu.be/iQyg-KypKAA | https://github.com/kunchenguid

---

## Phase 1 - WSL2 (Windows Subsystem for Linux)

This is the foundation. tmux and firstmate require it.

**Step 1: Install WSL2**

Open PowerShell as Administrator:
```powershell
wsl --install
```
- This installs Ubuntu by default
- **Restart your PC** when prompted
- After restart, Ubuntu will open and ask you to create a username + password

**Step 2: Verify WSL2**
```powershell
wsl --list --verbose
# Should show Ubuntu with VERSION 2
```

If it shows version 1:
```powershell
wsl --set-version Ubuntu 2
```

---

## Phase 2 - WezTerm

**Step 3: Install WezTerm on Windows**
- Go to https://wezterm.org → Download → Windows
- Run the `.exe` installer

**Step 4: Configure WezTerm to use WSL2**

Create or edit `C:\Users\<YourName>\.wezterm.lua`:
```lua
-- Copy from setup/wezterm.lua in this repo
```
Or just copy the file from `setup/wezterm.lua` in this repo to `~/.wezterm.lua`.

After this, opening WezTerm drops you straight into your WSL2 Ubuntu environment.

---

## Phase 3 - Core Tools in WSL2

Run all of these inside WSL2 (inside WezTerm after Phase 2).

**Step 5: Update packages and install tmux + Neovim**
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install tmux neovim git curl -y
```

**Step 6: Install Node.js via fnm (fast node manager)**
```bash
curl -fsSL https://fnm.vercel.app/install | bash
source ~/.bashrc
fnm install --lts
fnm use lts-latest
node --version  # should print v22.x or later
```

**Step 7: Set up tmux config**
```bash
cat > ~/.tmux.conf << 'EOF'
set -g mouse on
set -g base-index 1
set -g pane-base-index 1
bind c new-window -c "#{pane_current_path}"
set -g default-terminal "screen-256color"
EOF
```

---

## Phase 4 - Your agent (Codex and/or Claude Code)

The stack is agent-neutral. Pick one or both. Codex runs on a ChatGPT Plus/Pro
subscription; Claude Code needs a Claude plan or an Anthropic API key.

**Step 8: Install your agent CLI**
```bash
# Codex (OpenAI) - uses your ChatGPT subscription
npm install -g @openai/codex
# Native Windows alternative: irm https://chatgpt.com/codex/install.ps1 | iex

# Claude Code (Anthropic)
npm install -g @anthropic-ai/claude-code
```

**Step 9: Log in**
```bash
codex     # then choose "Sign in with ChatGPT" (Plus/Pro/Business/Edu/Enterprise)
# and/or
claude    # authenticate with your Anthropic account
```
Both agents read the same `AGENTS.md` / `OPINIONS.md` / `VOICE.md`, so your persona works either way.

**Step 10: Set up global agent instructions**

Copy the templates from `setup/templates/` in this repo to your home directory:
```bash
cp setup/templates/AGENTS.md ~/AGENTS.md
cp setup/templates/OPINIONS.md ~/OPINIONS.md
cp setup/templates/VOICE.md ~/VOICE.md
```
Then open each file and fill in YOUR actual opinions, preferences, and writing style.
This is the most important personalization step - agents will read these files.

---

## Phase 5 - Kun's Custom Tools

**Step 11: gnhf - "Good Night, Have Fun"**

Lets agents run big tasks overnight while you sleep.
```bash
npm install -g gnhf
# Usage: gnhf "implement the user authentication system"
```

**Step 12: treehouse - Parallel worktrees**

Manage parallel git worktrees so multiple agents work simultaneously.
```bash
# Inside WSL2:
curl -fsSL https://kunchenguid.github.io/treehouse/install.sh | sh
# Native Windows PowerShell alternative: irm https://kunchenguid.github.io/treehouse/install.ps1 | iex
# Usage (in any git repo): treehouse
```

**Step 13: no-mistakes - Clean PRs**

Intercepts git push to validate code before it reaches your real remote.
It is a Go tool, not an npm package.
```bash
# Inside WSL2:
curl -fsSL https://raw.githubusercontent.com/kunchenguid/no-mistakes/main/docs/install.sh | sh
# Windows-native / Go / source instructions:
# https://kunchenguid.github.io/no-mistakes/start-here/installation/
```

**Step 14: firstmate - Multi-agent orchestrator**

Talk to one agent that manages a whole crew of parallel agents.
firstmate is not a package - it is a repo you clone and run your agent inside.
```bash
# Inside WSL2, with tmux running and gh authenticated (gh auth login):
git clone https://github.com/kunchenguid/firstmate
cd firstmate && codex     # or: claude - run your agent inside the repo
```
Requires tmux, git + GitHub auth, and a verified agent (codex/claude/opencode/pi). WSL2 only on Windows.

**Step 15: lavish-axi - Visual HTML planning**

No install needed - run with npx when you want visual plans:
```bash
npx lavish-axi
# Or tell your agent: "draft a plan using npx lavish-axi"
```

---

## Phase 6 - Voice Input

OpenSuperWhisper (what Kun uses) is macOS only. Best Windows alternatives:

**Option A: OpenWhispr** (recommended - cross-platform, open source)
- https://github.com/OpenWhispr/openwhispr
- Download the Windows release, install, set your hotkey
- Press hotkey → speak → text appears at cursor

**Option B: Simple Windows Super Whisper** (built for devs using AI tools)
- https://github.com/Zoroboak/simple-windows-super-whisper

---

## Phase 7 - Neovim + agent integration

Note: a simpler path is to skip the manual steps below and just copy the ready
config from this repo: `cp setup/tools/nvim-init.lua ~/.config/nvim/init.lua`.
The manual version is here so you understand what it does.


**Step 16: Install a Neovim plugin manager**
```bash
# Install lazy.nvim
git clone --filter=blob:none https://github.com/folke/lazy.nvim.git \
  --branch=stable ~/.local/share/nvim/lazy/lazy.nvim
```

**Step 17: Add the agent integration plugin**

Add to `~/.config/nvim/init.lua`:
```lua
require("lazy").setup({
  {
    "coder/claudecode.nvim",
    config = true,
  },
})
```

This lets Neovim connect to your agent so it has full editor access.
(The plugin is named for Claude Code but the editor-server pattern works alongside other agents too.)

---

## Daily Workflow (How Kun Uses This)

```bash
# Start a tmux session
tmux new-session -s work

# Window 1: your agent
codex     # or: claude

# Ctrl+B C to open new window
# Window 2: Neovim
nvim .

# Ctrl+B C for another window
# Window 3: treehouse for a parallel task
treehouse

# Before going to bed, start a big overnight task:
gnhf "build out the complete settings page with all subsections"

# When pushing, no-mistakes validates everything:
git push  # no-mistakes intercepts and runs checks first
```

---

## Verification Checklist

After setup, verify each tool:
- [ ] `wsl --list --verbose` shows Ubuntu VERSION 2
- [ ] WezTerm opens into WSL2 Ubuntu automatically
- [ ] `tmux --version` works
- [ ] `nvim --version` works
- [ ] `node --version` shows v20+
- [ ] your agent works: `codex --version` and/or `claude --version`
- [ ] `gnhf --version` works
- [ ] `treehouse --version` works
- [ ] `~/AGENTS.md` exists and is filled in
- [ ] `~/OPINIONS.md` exists and is filled in
- [ ] `~/VOICE.md` exists and is filled in
- [ ] Voice input (OpenWhispr) installed and hotkey configured

---

## Troubleshooting

**WezTerm not opening WSL2**: Make sure `~/.wezterm.lua` exists and has the correct config.

**tmux: command not found**: You're not in WSL2. Open WezTerm after configuring it in Phase 2.

**node not found after install**: Run `source ~/.bashrc` or restart the terminal.

**firstmate not working**: Confirm you're inside WSL2 and tmux is running.

**Agent auth issues**: for Claude Code run `claude auth logout` then `claude`; for Codex re-run `codex` and sign in with ChatGPT again.
