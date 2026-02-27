---
name: memory-v3-setup
description: Install Memory V3 -- a session-continuity system for AI coding agents. Creates handoff files, hooks, and skills so the agent remembers what happened between sessions.
---

# Memory V3 Setup -- Agent Session Continuity System

You are installing Memory V3 into this codebase. Memory V3 solves the "amnesia problem" -- AI agents lose all context between sessions. V3 gives you: shift-change notes, working memory, narrative history, and a Stop hook that reminds you to save state before context is cleared.

**Analogy for the user:** Imagine hiring someone who gets amnesia every night. Every morning they show up to your workshop with zero memory of yesterday. Memory V3 is the set of notes their yesterday-self leaves them so they can start working immediately instead of spending the first hour asking "what was I doing?"

---

## What Gets Installed

| File | Analogy | Purpose |
|------|---------|---------|
| **MEMORY.md** | The note on the fridge | Auto-loaded index that says "read HANDOFF.md first" |
| **HANDOFF.md** | Letter from yesterday's you | 5-layer shift-change notes: state, story, decisions, priorities, warnings |
| **HOT_CONTEXT.md** | Pinboard above your desk | Top 5-10 things that matter RIGHT NOW. Small on purpose. |
| **NARRATIVE.md** | Project journal | The story -- not what happened, but why it mattered |
| **/handoff skill** | The act of writing the letter | Guides agent through saving all session state |

---

## Installation

### Step 1: Create MEMORY.md

Create `MEMORY.md` in the project root:

```markdown
# [Project Name] -- Memory V3

## SESSION START PROTOCOL
1. Read `HANDOFF.md` FIRST -- it has your previous self's state, priorities, and warnings
2. Scan `HOT_CONTEXT.md` -- the 5-10 things that matter right now
3. Only read detailed docs if the task requires deep understanding

## SESSION END PROTOCOL
When wrapping up, run /handoff if meaningful work was done this session.

## Deep Reference Docs
- **[NARRATIVE.md](./NARRATIVE.md)** -- Project history, breakthroughs, decisions, and lessons learned
```

### Step 2: Create HANDOFF.md

Create `HANDOFF.md` with initial state:

```markdown
# Session Handoff
Updated: [current ISO datetime]

## State
- Project just created
- Memory V3 installed

## Story
[Brief description of what this project is and where it's at]

## Decisions
- [DECIDED] Memory V3 installed for session continuity

## Next
1. [What to work on next]

## Warnings
- This is the initial handoff -- knowledge is being built for the first time
```

### Step 3: Create HOT_CONTEXT.md

```markdown
# Hot Context -- What Matters Right Now
Updated: [current date]

- Project just started -- everything is new
- Memory V3 active -- /handoff at end of session
```

### Step 4: Create NARRATIVE.md

```markdown
# The Story So Far

## The Project
[Extract from README: what is this project, who is it for, what does it do]

## Memory V3 Installed -- [today's date]
Memory V3 was added to give the AI agent session continuity.
```

### Step 5: Create /handoff Skill

Create `.cursor/skills/handoff/SKILL.md`:

```markdown
---
name: handoff
description: Save session state before context is cleared. Writes shift-change notes so your future self can pick up exactly where you left off.
---

# /handoff -- Session State Handoff

You are writing notes for your future self. That future self will wake up with no memory of this conversation. Make these notes count.

## Step 1: Write HANDOFF.md
Use the 5-layer structure: State, Story, Decisions, Next, Warnings.
Be specific. Your future self has ZERO context.

## Step 2: Update HOT_CONTEXT.md
Rewrite with current top 5-10 items. Remove stale items. Add new ones.

## Step 3: Update NARRATIVE.md (only if significant)
Append if: breakthrough, architectural decision, new phase, or lesson learned.

## Step 4: Confirm
Tell the user what you saved. 2-3 sentence summary.
```

### Step 6: Confirm

Tell the user what was installed and how to use it:
- Sessions start by reading HANDOFF.md (automatic via MEMORY.md)
- Sessions end with /handoff
- Suggest they test it: close this session, open a new one, and see if the handoff works
