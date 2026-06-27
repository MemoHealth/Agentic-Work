# Agent Skills

Skills are modular packages that extend an agent's abilities.
Kun's tools (the AXI family) and ponytail are all installed as skills.

## The skills CLI (`npx skills`)

The installer for all of these is Vercel's open skills CLI: https://github.com/vercel-labs/skills
No global install needed - it runs via `npx`. Works on Windows, macOS, Linux.

Common commands:
```bash
# Add a skill from a GitHub repo (owner/repo), pick the skill, -g installs it globally
npx skills add <owner/repo> --skill <name> -g

# List what a repo offers
npx skills add <owner/repo> --list

# List installed skills (optionally per agent)
npx skills list
```

It supports 18+ agents (Claude Code, Copilot, Cursor, Cline, and more) and GitHub shorthand, full URLs, GitLab, git URLs, and local paths.

## Install everything (run these on your machine)

```bash
# Kun's AXI tools
npx skills add kunchenguid/gh-axi --skill gh-axi -g
npx skills add kunchenguid/chrome-devtools-axi --skill chrome-devtools-axi -g
npx skills add kunchenguid/lavish-axi --skill lavish

# Write-less-code skill (by DietrichGebert, not Kun)
# Check the repo README for the exact current add command:
#   https://github.com/DietrichGebert/ponytail
```

Then confirm:
```bash
npx skills list
```

## What each one is

| Skill | What it does | Doc |
|---|---|---|
| gh-axi | Token-efficient GitHub CLI built for agents | `axi.md` |
| chrome-devtools-axi | Agent-ergonomic browser automation | `axi.md` |
| lavish-axi | Review agent-generated HTML plans visually in the browser | `axi.md` |
| ponytail | Makes the agent write the minimum amount of code | `ponytail.md` |

## Prerequisites

- Node 20+ (installed via fnm in `../windows-setup.md`)
- For gh-axi: the GitHub `gh` CLI installed and authenticated (`gh auth login`)
