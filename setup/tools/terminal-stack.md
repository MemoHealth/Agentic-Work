# Terminal stack - WezTerm + tmux + Neovim

This is the "cockpit" Kun works in. You are new to the terminal, so this doc explains what each piece is for and gives you working configs to start from. Treat it as something to grow into, not master on day one.

## How the three fit together

- **WezTerm** = the window. A fast, good-looking terminal program that runs on Windows and opens your WSL2 Linux inside it.
- **tmux** = the layout. It splits that one window into multiple panes and tabs that survive even if you close WezTerm. Kun runs Claude Code in one tmux window, Neovim in another, and parallel agents in more windows.
- **Neovim** = the editor. A keyboard-driven code editor. Claude Code can connect to it so the agent sees what you have open.

You can get value from WezTerm + tmux + Claude Code alone. Neovim is optional since you do not edit code by hand - add it later if you want.

## WezTerm

Install on Windows (not inside WSL2): https://wezterm.org
Config file goes at `C:\Users\<You>\.wezterm.lua`.
A ready config is in this repo at `../wezterm.lua` - copy it there. It opens straight into WSL2 Ubuntu.

## tmux

Install inside WSL2: `sudo apt install tmux -y`
Config goes at `~/.tmux.conf` inside WSL2. A starter config is in this folder: `tmux.conf` - copy it with:
```bash
cp setup/tools/tmux.conf ~/.tmux.conf
```

Survival commands (the prefix is `Ctrl+b`, press it then the next key):
| Action | Keys |
|---|---|
| New window (tab) | `Ctrl+b` then `c` |
| Next / previous window | `Ctrl+b` then `n` / `p` |
| Split left-right | `Ctrl+b` then `%` |
| Split top-bottom | `Ctrl+b` then `"` |
| Move between panes | `Ctrl+b` then arrow key |
| Detach (leave it running) | `Ctrl+b` then `d` |
| Re-attach later | `tmux attach` |

A typical session:
```bash
tmux new -s work     # start
# window 1: claude
# Ctrl+b c -> window 2: nvim .
# Ctrl+b c -> window 3: treehouse / another agent
```

## Neovim (optional)

Install inside WSL2: `sudo apt install neovim -y`
A minimal starter config is in this folder: `nvim-init.lua`. Copy it with:
```bash
mkdir -p ~/.config/nvim
cp setup/tools/nvim-init.lua ~/.config/nvim/init.lua
```
It sets sane defaults and installs the Claude Code integration plugin (`coder/claudecode.nvim`) so the agent can see your editor. First launch will take a moment to download the plugin manager.

Bare-minimum Neovim survival:
| Action | Keys |
|---|---|
| Quit | `:q` then Enter |
| Save | `:w` then Enter |
| Save and quit | `:wq` then Enter |
| Quit without saving | `:q!` then Enter |
| Enter insert mode (type text) | `i` |
| Leave insert mode | `Esc` |

If Neovim feels like too much while you are learning, skip it. WezTerm + tmux + Claude Code is the core.
