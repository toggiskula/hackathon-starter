# The Story So Far

## What This Repo Is

A starter kit for building something from scratch with AI. Clone it, open it in Cursor,
and the agent walks you through a structured workflow:

**Brainstorm -> Intent -> Plan -> Build -> Polish**

The skills are numbered by the order you use them:
1. Brainstorming + Intent Engineering (shape the idea)
2. Adversarial Review (stress-test the design -- optional, for complex projects)
3. Subagent-Driven Development (build with parallel agents + two-stage review)
4. Code Simplifier (clean up AI-generated code)
5. Verification Before Completion (prove it works before claiming done)

## Why This Workflow

This is not "type a prompt and hope." Each step exists because it solves a real problem:

- **Brainstorming** prevents building the wrong thing
- **Intent.md** gives every agent a shared understanding of what you want
- **Planning** keeps scope realistic for the time you have
- **Two-stage review** (spec compliance + code quality) catches bugs that single-pass generation misses
- **Verification** means you leave with something that actually runs

The workflow was proven by building [QuickCursor](https://github.com/greenqloud/QuickCursor) --
a 37-file Tauri desktop app created in a single session. Three adversarial reviewers found
8 design issues before any code was written. Two-stage review caught 5 implementation bugs
during the build. The app works.

## What Happens Next

You open this repo, say hello (or type /start), and the agent picks up from here.
Build something. Memory auto-updates as you work, so you or someone else can continue
later without losing context.
