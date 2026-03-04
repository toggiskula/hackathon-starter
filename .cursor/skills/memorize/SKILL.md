---
name: memorize
description: Thorough memory save. Rewrites memory.mdc with full project state, updates NARRATIVE.md if something significant happened. Use when you want a complete checkpoint, not just the automatic incremental updates.
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

Keep the `alwaysApply: true` frontmatter. Be specific. Your future self has ZERO context
beyond what this rule injects.

## Step 2: Update NARRATIVE.md (only if significant)

Append to `NARRATIVE.md` in the project root if something significant happened:
a breakthrough, an architectural decision, a new phase, or a lesson learned.
Skip for routine work.

## Step 3: Confirm

Tell the user what you saved. 2-3 sentence summary of what the next session will see.
