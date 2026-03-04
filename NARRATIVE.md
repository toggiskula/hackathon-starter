# The Story So Far

## What This Repo Is

A starter kit for building something from scratch with AI. Clone it, open it in Cursor,
and the agent walks you through a structured workflow:

**Brainstorm -> Intent -> Plan -> Adversarial Review -> Build + Review -> Polish -> Verify**

The skills are numbered by the order you use them:
1. Brainstorming + Intent Engineering (shape the idea)
2. Write Plan (2-4 concrete tasks, saved to docs/plans/)
3. Adversarial Review (3 hostile agents attack the plan -- optional, time-permitting)
4. Subagent-Driven Development (build with parallel agents + two-stage review per task)
5. Code Simplifier (clean up AI-generated code)
6. Verification Before Completion (prove it works before claiming done)

## Why This Workflow

This is not "type a prompt and hope." Each step exists because it solves a real problem:

- **Brainstorming** prevents building the wrong thing
- **Intent.md** gives every agent a shared understanding of what you want (5-10 lines, not a spec)
- **Planning** produces a concrete 2-4 task plan scoped to the time you have
- **Adversarial review** attacks the plan before a line is written -- cheaper than debugging
- **Two-stage review** (spec compliance + code quality) catches bugs that single-pass generation misses
- **Verification** means you leave with something that actually runs

The workflow was proven by building [QuickCursor](https://github.com/greenqloud/QuickCursor) --
a Tauri desktop app (floating panel, Cmd+Shift+R, wraps cursor-agent with a markdown knowledge vault)
built with this exact pipeline. The adversarial review changed the design significantly before any
code was written. The app is now 10+ commits in and still being developed.

## Key Architecture Decisions (Mar 4, 2026)

- **Pipeline reordered**: Intent -> Write Plan -> Adversarial Review (attacks plan) -> Build
- **AskQuestion at every phase transition**: agent drives, never stops passively
- **Stop hook removed**: it fired after every response and broke AskQuestion flow
- **memory.mdc is the sole memory mechanism**: alwaysApply: true, updated silently on file edits
- **/skills command**: type it anytime to see the skills table and how to invoke each one
- **QuickCursor description corrected**: headless Cursor + knowledge base, not a clipboard tool

## What Happens Next

You open this repo, say hello (or type /start), and the agent picks up from here.
Build something. Memory auto-updates as you work, so you or someone else can continue
later without losing context.
