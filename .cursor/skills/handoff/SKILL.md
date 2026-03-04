---
name: handoff
description: Save session state before context is cleared. Writes shift-change notes so your future self can pick up exactly where you left off.
---

# /handoff -- Session State Handoff

You are writing notes for your future self. That future self will wake up with no
memory of this conversation. Make these notes count.

## Step 1: Write HANDOFF.md

Update `HANDOFF.md` in the project root with the 5-layer structure:

- **State** -- what exists now (project status, what is built, what is broken)
- **Story** -- 2-3 sentence narrative of what happened this session
- **Decisions** -- key choices made and their rationale
- **Next** -- what the next session should do first
- **Warnings** -- gotchas, blockers, things that will bite the next person

Be specific. Your future self has ZERO context.

## Step 2: Update HOT_CONTEXT.md

Rewrite `HOT_CONTEXT.md` in the project root with the current top 5-10 items.
Remove stale items. Add new ones. This is working memory -- what matters RIGHT NOW.

## Step 3: Update NARRATIVE.md (only if significant)

Append to `NARRATIVE.md` if something significant happened: a breakthrough,
an architectural decision, a new phase, or a lesson learned. Skip for routine work.

## Step 4: Confirm

Tell the user what you saved. 2-3 sentence summary of what the next session will see.
