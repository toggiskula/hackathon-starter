---
name: session-memory
description: Install session memory -- a lightweight continuity system so the agent remembers what happened between sessions. Uses a single .cursor/rules/memory.mdc file (auto-injected by Cursor) and a rule that tells the agent to keep it current. Zero dependencies, zero setup beyond the files themselves.
---

# Session Memory Setup

You are installing session memory into this codebase. This solves the "amnesia problem" -- AI agents lose all context between sessions.

**How it works:**
1. Cursor automatically injects `.cursor/rules/memory.mdc` (with `alwaysApply: true`) into every conversation -- the agent sees project state without reading any files.
2. A rule tells the agent: "When you create or edit files, update memory.mdc in the same response." No hook, no reminder. The agent keeps memory current as it works.
3. `/memorize` is available as an optional thorough save for full checkpoints.

---

## What Gets Installed

| File | Purpose |
|------|---------|
| `.cursor/rules/memory.mdc` | Session state: what exists, what to do, decisions, warnings. Auto-injected every session, updated by the agent after file changes. |
| `NARRATIVE.md` (root) | Project journal -- the story over time. Read on demand, not auto-injected. |
| `.cursor/skills/memorize/SKILL.md` | Optional thorough save skill. |
| `.cursor/commands/memorize.md` | `/memorize` command entry point. |

---

## Installation

### Step 1: Create memory.mdc

Create `.cursor/rules/memory.mdc`:

```
---
alwaysApply: true
---

# Session Memory

Updated: [current ISO date]

## State

- Project just created
- Session memory installed

## What You Should Do

[Brief instructions for the next agent session]

## Context

[Working details: tools, frameworks, current priorities]

## Decisions

(none yet)

## Warnings

- [Any gotchas or things to watch out for]
```

### Step 2: Add the memory update rule

In your project's main always-on rule (or create one), add this directive:

```
## Memory System

**When you create or edit files, update `.cursor/rules/memory.mdc` in the same response.**
This is the only memory mechanism. Keep it current.

What to update:
- **State section:** What exists now (files created, frameworks in use, what works, what is broken)
- **Context section:** Current phase, what matters right now
- **Decisions section:** Key choices and rationale (append, do not overwrite)
- **Warnings section:** Gotchas for the next session

Keep it concise (under 15 lines in State/Context). Update the `Updated` date. Do this silently.
When NOT to update: Pure conversation with no file changes.
```

### Step 3: Create NARRATIVE.md

Create `NARRATIVE.md` in the project root:

```markdown
# The Story So Far

## The Project

[Extract from README: what is this project, who is it for, what does it do]

## Session Memory Installed -- [today's date]

Session memory was added to give the AI agent session continuity.
```

### Step 4: Create /memorize skill and command

Create `.cursor/skills/memorize/SKILL.md`:

```markdown
---
name: memorize
description: Thorough memory save. Rewrites memory.mdc with full project state, updates NARRATIVE.md if something significant happened.
---

# /memorize -- Save Session State

You are writing notes for your future self. That future self will wake up with no
memory of this conversation. But it WILL automatically see `.cursor/rules/memory.mdc`.
Make these notes count.

## Step 1: Rewrite memory.mdc

Rewrite `.cursor/rules/memory.mdc` with a thorough snapshot:

- **State** -- what exists now (project status, what is built, what is broken)
- **What You Should Do** -- clear instructions for the next session's agent
- **Context** -- working details: what tools/frameworks are in use, what matters right now
- **Decisions** -- key choices made and their rationale
- **Warnings** -- gotchas, blockers, things that will bite the next person

Keep the `alwaysApply: true` frontmatter. Be specific.

## Step 2: Update NARRATIVE.md (only if significant)

Append to `NARRATIVE.md` if something significant happened. Skip for routine work.

## Step 3: Confirm

Tell the user what you saved. 2-3 sentence summary.
```

Create `.cursor/commands/memorize.md`:

```markdown
Save a thorough checkpoint of current session state.

Follow the memorize skill at `.cursor/skills/memorize/SKILL.md`:

1. Rewrite `.cursor/rules/memory.mdc` with full project state, decisions, and warnings
2. Append to `NARRATIVE.md` if something significant happened
3. Tell the user what you saved
```

### Step 5: Confirm

Tell the user what was installed and how it works:
- Memory auto-updates when the agent creates or edits files (no manual saving)
- `/memorize` is available for thorough checkpoints
- `NARRATIVE.md` captures the project story over time
- Suggest they test it: do some work, close the session, open a new one, and see if the agent knows what happened
