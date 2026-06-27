# AXI - Agent eXperience Interface

AXI is Kun Chen's design standard for CLI tools built for AI agents, plus a family of reference tools that follow it.
Site: https://axi.md | Repo: https://github.com/kunchenguid/axi

## The idea

Most tools are designed for humans (GUIs) or for machines (raw JSON APIs / MCP).
AXI argues agents deserve their own first-class interface: a CLI that treats the agent's token budget as a hard constraint.
The claim: AXI hits the reliability of MCP (structured output, discoverability) at the cost profile of a plain CLI - higher accuracy, lower token cost.

## The 10 principles (summary)

1. Token-efficient output using TOON format (~40% fewer tokens than JSON)
2. Minimal default schemas (3-4 fields per list item)
3. Content truncation with size hints and an escape hatch to get more
4. Pre-computed aggregates so the agent avoids extra round trips
5. Definitive empty states (explicit "0 results")
6. Structured errors and exit codes, never interactive prompts
7. Ambient context through session integrations and skills
8. Content first - live data without help-text noise by default
9. Contextual disclosure - suggest the likely next step
10. Consistent help access via per-subcommand reference

You do not need to memorize these. They matter because they are why Kun's tools feel fast and cheap for agents.

## Why this is relevant to Jonathan

You do not read code, so you rely on agents being accurate and not burning budget on noise.
AXI tools are built exactly for that: less wasted context, fewer failed turns, more trustworthy results.

## The AXI tools

### gh-axi - GitHub for agents

A GitHub CLI wrapper with token-efficient output, next-step suggestions, and structured errors.
Lets agents manage issues, pull requests, workflow runs, releases, and repos cheaply.
Needs the `gh` CLI installed and authenticated. Works on Windows.
```bash
npx skills add kunchenguid/gh-axi --skill gh-axi -g
```

### chrome-devtools-axi - browser for agents

Agent-ergonomic browser automation (wraps chrome-devtools-mcp).
Opens pages, clicks through flows, extracts content, debugs console/network, audits performance.
Combines steps into single commands and trims output ~40% vs raw JSON. Works on Windows.
```bash
npx skills add kunchenguid/chrome-devtools-axi --skill chrome-devtools-axi -g
```

### lavish-axi - visual planning in HTML

"HTML is the new markdown." Instead of a plan in plain markdown, the agent renders an interactive HTML page.
You open it in a local browser, click elements or select text, and send feedback straight back to the agent.
This is the tool you specifically liked for "better Claude design". Works on Windows.
```bash
npx skills add kunchenguid/lavish-axi --skill lavish
```
Use it inside Claude Code with:
```
/lavish let's discuss our plan here
```
Or run manually: `npx lavish-axi <html-file>`

## How AXI sits next to your other files

- AGENTS.md / OPINIONS.md / VOICE.md = how the agent thinks, decides, and writes like you.
- AXI tools = the efficient hands the agent uses to touch GitHub, the browser, and plans.
