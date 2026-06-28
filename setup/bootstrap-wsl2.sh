#!/usr/bin/env bash
# bootstrap-wsl2.sh
# Run this INSIDE WSL2 Ubuntu, from the root of the cloned Agentic-Work repo.
# It automates the WSL2-side of the setup in the right order.
#
# What it does NOT do (you must do these manually):
#   - install WSL2 itself or WezTerm (those are on the Windows side)
#   - sign in to Codex or Claude (browser auth with your own accounts)
#
# Usage:
#   git clone <this repo> && cd Agentic-Work
#   bash setup/bootstrap-wsl2.sh

set -uo pipefail

info() { printf "\n\033[1;36m== %s ==\033[0m\n" "$1"; }
warn() { printf "\033[1;33m!! %s\033[0m\n" "$1"; }

# 0. Make sure we are in the repo root
if [ ! -f setup/templates/AGENTS.md ]; then
  warn "Run this from the root of the cloned Agentic-Work repo (the folder that contains setup/)."
  exit 1
fi

# 1. Base tools
info "Installing base tools (tmux, neovim, git, curl)"
sudo apt update && sudo apt install -y tmux neovim git curl

# 2. Node via fnm
info "Installing Node via fnm"
if ! command -v fnm >/dev/null 2>&1; then
  curl -fsSL https://fnm.vercel.app/install | bash
fi
export PATH="$HOME/.local/share/fnm:$PATH"
eval "$(fnm env 2>/dev/null)" || true
fnm install --lts || warn "fnm install failed - open a new shell and re-run if npm steps fail below"
fnm use lts-latest 2>/dev/null || true
node --version || warn "node not on PATH yet"

# 3. npm-based agents and tools
info "Installing gnhf, Codex CLI, and Claude Code"
npm install -g gnhf @openai/codex @anthropic-ai/claude-code || warn "one or more npm installs failed"

# 4. treehouse (parallel worktrees)
info "Installing treehouse"
curl -fsSL https://kunchenguid.github.io/treehouse/install.sh | sh || warn "treehouse install failed - see https://github.com/kunchenguid/treehouse"

# 5. no-mistakes (Go tool, via official script)
info "Installing no-mistakes"
curl -fsSL https://raw.githubusercontent.com/kunchenguid/no-mistakes/main/docs/install.sh | sh || warn "no-mistakes install failed - see https://kunchenguid.github.io/no-mistakes/start-here/installation/"

# 6. Persona files
info "Copying persona files to home (AGENTS / OPINIONS / VOICE)"
cp -i setup/templates/AGENTS.md   "$HOME/AGENTS.md"
cp -i setup/templates/OPINIONS.md "$HOME/OPINIONS.md"
cp -i setup/templates/VOICE.md    "$HOME/VOICE.md"

# 7. Terminal configs
info "Installing tmux and Neovim configs"
cp -i setup/tools/tmux.conf "$HOME/.tmux.conf"
mkdir -p "$HOME/.config/nvim"
cp -i setup/tools/nvim-init.lua "$HOME/.config/nvim/init.lua"

# 8. Agent skills (AXI family). These may ask which agent to install into.
info "Installing agent skills (gh-axi, chrome-devtools-axi, lavish)"
npx -y skills add kunchenguid/gh-axi --skill gh-axi -g || warn "gh-axi skill add failed"
npx -y skills add kunchenguid/chrome-devtools-axi --skill chrome-devtools-axi -g || warn "chrome-devtools-axi skill add failed"
npx -y skills add kunchenguid/lavish-axi --skill lavish || warn "lavish skill add failed"

# 9. firstmate (clone-based, not a package)
info "Cloning firstmate"
if [ ! -d "$HOME/firstmate" ]; then
  git clone https://github.com/kunchenguid/firstmate "$HOME/firstmate" || warn "firstmate clone failed"
else
  echo "firstmate already cloned at ~/firstmate"
fi

cat <<'NEXT'

============================================================
WSL2-side setup is done. Remaining MANUAL steps:

1. Sign in to your agent(s):
     codex     -> choose "Sign in with ChatGPT"
     claude    -> log in with your Anthropic account
2. (For gh-axi) authenticate GitHub:   gh auth login
3. (Optional) ponytail skill:          https://github.com/DietrichGebert/ponytail
4. Voice input (Windows side):         OpenWhispr
5. WezTerm config is on the WINDOWS side:
     copy setup/wezterm.lua to  C:\Users\<You>\.wezterm.lua

Start working:
     tmux new -s work
     codex            # or: claude

Run firstmate later with:
     cd ~/firstmate && codex
============================================================
NEXT
