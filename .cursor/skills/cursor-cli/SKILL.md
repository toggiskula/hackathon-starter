---
name: cursor-cli
description: Knowledge dump on Cursor CLI (the agent binary) and its agent output behaviors.
---

Here's a complete, production-ready knowledge dump on Cursor CLI (the agent binary) and its agent output behaviors. This is tailored for your native app that interfaces directly with the Cursor Agent (via CLI exec or subprocess). I've structured it for your dev agent to exceed expectations: exact invocation patterns, parsing logic for every output mode, UI mapping recommendations (especially for the Confluence/Atlassian example in your screenshot), edge cases, and design guardrails.This is based on the official Cursor CLI docs (as of March 2026), MCP integration details, and observed behaviors from Atlassian/vault MCP plugins. Use this as the canonical spec for your app's backend parser and frontend renderer.1. Core Concepts & CapabilitiesCursor CLI (agent command) gives you the exact same Agent as the IDE, but headless/terminal-first. It supports:Full agentic workflow: Read/write files, shell execution (sandboxed), semantic search, @-mentions, multi-step planning.
Modes (set via --mode or slash commands in interactive):agent (default): Full tools, writes, shell.
plan: Clarifying questions only (no changes).
ask: Read-only exploration.

MCP (Model Context Protocol) plugins — This powers your screenshot's Atlassian integration.External tool servers (Jira/Confluence, Vault for secrets/knowledge base, GitHub, Slack, Playwright, etc.).
Configured globally in ~/.cursor/mcp.json or project .cursor/mcp.json.
Agent auto-discovers and uses them when helpful (e.g., "list Confluence pages" → calls Atlassian MCP tool).
Commands: agent mcp list, agent mcp list-tools <identifier> (e.g., atlassian or confluence-jira-gitlab).
Your screenshot example: Agent used Atlassian MCP tool(s) to fetch "15 most recently modified Confluence pages". The "10 tools used" is a GUI summary (IDE only); in CLI you count tool_call events yourself.

Vault MCP (mentioned in your screenshot warning): Separate MCP server for secrets/knowledge base. The yellow banner "The agent responded without searching your vault..." appears when the agent skips Vault-related tools (common in MCP setups). It is part of the final assistant text or a system note — not a separate JSON field.
Cloud handoff: Prefix prompt with & or --cloud to push to cursor.com/agents.
Sessions: Persistent via agent ls, agent resume, --continue, --resume=<id>.
Sandbox & security:--sandbox enabled|disabled
Shell/MCP approvals: --force / --yolo (bypasses), --approve-mcps (auto-approve all), --trust (headless workspace trust).
Sudo prompts handled securely (never exposed to model).

Capabilities summary for UI:Can list/modify code, run builds/tests, query external APIs (Confluence, Jira, etc.).
Multi-turn with history.
Tool-heavy tasks (your screenshot) can use 5–20+ tool calls per response.
No internet for installation, but MCP servers can call external APIs.

2. Invocation Patterns (What Your App Must Support)Always run in non-interactive mode for a native app:bash

agent -p "your prompt here" \
  --output-format stream-json \   # RECOMMENDED for real-time UI
  --stream-partial-output \      # Optional: char-by-char deltas
  --model "claude-4-sonnet" \    # Or gpt-5.2, etc.
  --force \                      # Or --yolo for production automation
  --approve-mcps \
  --trust \
  --workspace "/path/to/project"

Interactive fallback (no -p): Terminal TUI — avoid for native app (no control).
Print mode (-p): Unlocks write/shell tools (required).
Env vars: CURSOR_API_KEY (fallback), workspace auto-detects.
Config files (your app should read these):~/.cursor/cli-config.json (global settings)
~/.cursor/mcp.json (plugins)
Project .cursor/cli.json or .cursor/mcp.json

For voice app: Pipe spoken prompt → exec → parse stream → speak/render.3. Output Formats & Exact Parsing Spec (Critical for UI)Use --output-format only with -p. Default = text.A. text (simple, final only)Just the final assistant message (markdown possible).
No tool details, no streaming, no warnings visible separately.
UI use: Fallback display only. Parse as one big markdown blob.

B. json (one-shot on completion)Success:json

{
  "type": "result",
  "subtype": "success",
  "is_error": false,
  "duration_ms": 1234,
  "duration_api_ms": 1234,
  "result": "<FULL assistant text, including any 'vault' warning or Confluence list>",
  "session_id": "<uuid>",
  "request_id": "optional"
}

Failure: non-zero exit + stderr (no JSON).UI: Good for simple responses; count tools = 0 (no visibility).C. stream-json (NDJSON — THIS IS WHAT YOU WANT) — Line-delimited JSON eventsEvery line = one event. Your parser must:Read line-by-line (real-time).
Accumulate assistant text.
Track tool_call count for "X tools used" badge (like your screenshot).
Detect Vault warning (string match in assistant text or final result).

Event types (in order):system / init (once) — cwd, model, session_id.
user (echo of prompt).
assistant (complete message block — emitted after each tool cycle).
tool_call:subtype: "started" → { "call_id": "...", "tool_call": { "readToolCall": {...} or "writeToolCall": {...} or "function": { "name": "atlassian-list-pages", ... } } }
subtype: "completed" → same + result.success (e.g., file content metadata or MCP return value).
Built-in: readToolCall, writeToolCall.
MCP: generic function with tool name (e.g., Atlassian Confluence tools).

Final result (success) — same as json format above.

Tool count logic (for your "10 tools used" UI badge):js

let toolsUsed = 0;
onEvent(event) {
  if (event.type === "tool_call" && event.subtype === "completed") toolsUsed++;
  // Or count started — whichever matches IDE
}

Render as a live counter (e.g., "Using tools... (3/10)" → final badge).Partial text streaming (--stream-partial-output flag):Only with stream-json.
Assistant events become character deltas (real-time typing effect).

Confluence example from your screenshot:Multiple tool_call events for Atlassian MCP (e.g., listRecentlyModifiedPages or similar).
Final assistant text = "Here are your 15 most recently modified Confluence pages:" + markdown list.
Vault warning appears in final result text if Vault MCP wasn't called.

Error handling:Non-zero exit → parse stderr.
Tool errors (MCP fail) → agent may retry or stop (see forum bugs); show in UI as red banner.

4. UI Design Recommendations (How to Exceed Expectations)Build your native UI around stream-json parsing:Live conversation view:User bubble (plain).
Agent: streaming text (markdown renderer + LaTeX support).
Real-time "tools in progress" carousel or list (parse tool_call started → show name/icon: "Atlassian MCP: listing pages").

Tool summary panel (top-right, like screenshot):"X tools used" badge (live counter).
Expandable log: each tool_call with args/result (collapsed by default).

Special banners (yellow like screenshot):String match: without searching your vault → show warning with "Enable Vault MCP?" button.
Other patterns: "sandbox disabled", approval prompts, etc.

Structured output rendering:Confluence lists → interactive cards (clickable links if MCP returns URLs).
Tables, code blocks → native components.
File edits → diff viewer.

Voice/Speaking integration:Stream partial text → TTS chunks.
Pause/resume on tool calls.
Speak tool summaries ("Agent used 10 tools, including Atlassian to fetch pages").

Session & history:Sidebar: agent ls results as chat list.
Resume via --resume.

Approvals & safety (headless):Pre-apply --force --approve-mcps --trust.
Or surface interactive confirmations in your app UI.

Performance/Edge cases:Long-running: Agent can hang (known bug in some versions) → timeout + retry.
Large outputs: MCP can return huge Confluence data → truncate + "view full" button.
No MCP? Fallback message + prompt user to configure mcp.json.
Model switching: Expose --model picker.

Config management:Your app should auto-detect/edit mcp.json and cli-config.json.
One-click "Add Atlassian plugin" → writes the official MCP entry.

5. Quick-Start Template for Your Dev Agentbash

# Test command that matches your screenshot
agent -p "Can u use atlassian plugin to list some pages I've made on confluence" \
  --output-format stream-json \
  --stream-partial-output \
  --force --approve-mcps --trust

Parse the stream → render exactly like the screenshot (tools count + warning + list).This spec covers everything the CLI can output today (including future-proof unknown fields — ignore them). Your native app will feel native to Cursor while adding voice-first polish.Drop this entire dump into your dev agent's context — it will generate pixel-perfect UI code and parser in one shot. Want me to output sample parser code (TypeScript/Python) or a Figma-style UI mock description next? Just say the word.