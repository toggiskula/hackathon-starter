---
name: intent-engineering
description: "Capture a clear, structured vision document (Intent.md) before designing or building anything. Use when the user describes a new project, product, tool, or significant feature they want to create."
---

# Intent Engineering

Transform a rough idea into a structured Intent.md that becomes the north star for everything that follows. The Intent.md is not a plan (that comes later) - it is a declaration of what, why, and the constraints that shape the solution.

## When to Use

- User describes something they want to build ("I want to create...", "Can we build...", "What if we had...")
- User has a vision but hasn't structured it yet
- Before using `brainstorming` or implementation skills
- At the start of any project that will take more than a few hours

## The Hard Gate

Do NOT proceed to brainstorming, planning, or implementation until an Intent.md exists and the user has confirmed it captures their vision. The intent document is the foundation everything else builds on.

## Process

### Step 1: Capture the Raw Vision

Extract from the user's message (or ask if missing):

| Element | Question | Example |
|---|---|---|
| **Name** | What is this called? | "QuickCursor" |
| **One-liner** | What does it do in one sentence? | "Spotlight-style overlay for Cursor CLI" |
| **Paradigm** | What is this similar to? | "What Cowork is for Claude Code" |
| **User** | Who is this for? | "Developers who want quick AI access" |
| **Trigger** | What makes them reach for this? | "Want to ask AI without opening IDE" |

Do NOT ask all questions at once. Extract what you can from the user's message, then ask about the missing pieces one at a time.

### Step 2: Research the Landscape

Before structuring the intent, research using available tools:

- **Web search**: Existing solutions, competing products, prior art
- **Codebase exploration**: Relevant existing code, patterns, constraints
- **Documentation**: Specs, APIs, or platform docs that constrain the solution

Spend 2-5 minutes on research. The goal is to ground the intent in reality, not to become an expert.

### Step 3: Structure into Intent.md

Write the document at `Intent.md` in the project root. Follow this structure exactly:

```markdown
# {Project Name} - Intent Document

## Vision
{2-3 sentences. What is this, who is it for, what paradigm does it follow.}

## The Problem
{What pain exists today? Why do people need this? Be specific.}

## Core Principles
{3-5 numbered principles that constrain every decision. These are the rules
the project lives by. Each should be testable: you can look at a decision
and ask "does this violate principle #3?"}

## Architecture
{High-level tech stack, data flow, key components. Not detailed design -
that comes in brainstorming. Just enough to show the shape of the solution.}

## Scope
### V1 (This Build)
{Explicit list of what ships in v1. Be ruthless.}

### Future (Not V1)
{Things that are interesting but explicitly deferred. Prevents scope creep.}

## Key Decisions
{Major choices and their rationale. Format: "Why X over Y?" with a
1-2 sentence answer. These prevent relitigating decisions later.}
```

### Step 4: Confirm with User

Present the Intent.md and ask: "Does this capture what you want to build?"

Iterate until confirmed.

### Step 5: Save and Transition

1. Save the Intent.md to the project
2. Transition to `brainstorming` skill if the project needs design exploration
3. Or move directly to planning if the design is already clear

## What Makes a Good Intent.md

- **Principles are constraints, not aspirations.** "Be fast" is an aspiration. "Summon-to-prompt under 200ms" is a constraint.
- **Scope is explicit about what's excluded.** The "Future" section is as important as the "V1" section.
- **Decisions have rationale.** "Why Tauri over Electron? Binary size and resource efficiency" prevents the question from being asked again.
- **The problem is real and specific.** Not "it would be nice if..." but "developers must open the full IDE just to ask a quick question."

## What Makes a Bad Intent.md

- Reads like marketing copy
- Lists features without constraints
- No explicit scope boundary
- No decisions section (everything is "TBD")
- Too long (Intent.md should be 100-250 lines, not a specification)
