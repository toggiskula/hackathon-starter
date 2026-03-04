---
name: session-memory
description: Install session memory -- a lightweight continuity system so the agent remembers what happened between sessions. Uses a single .cursor/rules/memory.mdc file (auto-injected by Cursor) plus a stop hook that keeps it current. Zero manual saving required.
---

# Session Memory Setup

You are installing session memory into this codebase. This solves the "amnesia problem" -- AI agents lose all context between sessions.

**How it works:**
1. Cursor automatically injects `.cursor/rules/memory.mdc` (with `alwaysApply: true`) into every conversation -- the agent sees project state without reading any files.
2. A `stop` hook fires after each agent turn. If meaningful work was done, the agent silently updates `memory.mdc`. No user action needed.
3. `/memorize` is available as an optional thorough save. But automatic updates mean memory stays current even without it.

---

## What Gets Installed

| File | Purpose |
|------|---------|
| `.cursor/rules/memory.mdc` | Session state: what exists, what to do, decisions, warnings. Auto-injected every session, auto-updated by stop hook. |
| `.cursor/hooks.json` | Configures the stop hook that triggers memory checks. |
| `.cursor/hooks/memory-update.sh` | The hook script: asks the agent to update memory.mdc if meaningful work happened. |
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

### Step 2: Create the stop hook

Create `.cursor/hooks.json`:

```json
{
  "version": 1,
  "hooks": {
    "stop": [
      {
        "command": ".cursor/hooks/memory-update.sh",
        "loop_limit": 1
      }
    ]
  }
}
```

Create `.cursor/hooks/memory-update.sh`:

```bash
#!/bin/bash
INPUT=$(cat)

LOOP_COUNT=$(echo "$INPUT" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    print(data.get('loop_count', 0))
except:
    print('0')
" 2>/dev/null)

STATUS=$(echo "$INPUT" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    print(data.get('status', ''))
except:
    print('')
" 2>/dev/null)

if [ "$LOOP_COUNT" = "0" ] && [ "$STATUS" = "completed" ]; then
    cat << 'EOF'
{"followup_message": "[Memory check] If you made meaningful changes this turn (created/edited files, wrote code, made decisions, changed project direction), silently update .cursor/rules/memory.mdc to reflect the current state. Keep it under 15 lines in the State/Context sections. Update the 'Updated' date. If nothing significant happened, skip this entirely and say nothing."}
EOF
else
    echo '{}'
fi
```

Make it executable: `chmod +x .cursor/hooks/memory-update.sh`

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

Create `.cursor/skills/memorize/SKILL.md` and `.cursor/commands/memorize.md` for thorough saves on demand.

### Step 5: Confirm

Tell the user what was installed and how it works:
- Memory auto-updates after each agent turn via the stop hook (no manual saving)
- `/memorize` is available for thorough checkpoints
- `NARRATIVE.md` captures the project story over time
- Suggest they test it: do some work, close the session, open a new one, and see if the agent knows what happened
