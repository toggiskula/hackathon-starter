---
name: handoff
description: Save session state before context is cleared. Writes shift-change notes so your future self can pick up exactly where you left off.
---

# /handoff -- Session State Handoff

You are writing notes for your future self. That future self will wake up with no
memory of this conversation. But it WILL automatically see the `.cursor/rules/` files.
Make these notes count.

## Step 1: Update handoff.mdc

Rewrite `.cursor/rules/handoff.mdc` with the 5-layer structure:

- **State** -- what exists now (project status, what is built, what is broken)
- **Story** -- 2-3 sentence narrative of what happened this session
- **Decisions** -- key choices made and their rationale
- **Next** -- what the next session should do first
- **Warnings** -- gotchas, blockers, things that will bite the next person

Keep the `alwaysApply: true` frontmatter. Be specific. Your future self has ZERO context
beyond what these rules inject.

## Step 2: Update hot-context.mdc

Rewrite `.cursor/rules/hot-context.mdc` with the current top 5-10 items.
Remove stale items. Add new ones. This is working memory -- what matters RIGHT NOW.

Keep the `alwaysApply: true` frontmatter.

## Step 3: Update NARRATIVE.md (only if significant)

Append to `NARRATIVE.md` in the project root if something significant happened:
a breakthrough, an architectural decision, a new phase, or a lesson learned.
Skip for routine work.

## Step 4: Confirm

Tell the user what you saved. 2-3 sentence summary of what the next session will see.
