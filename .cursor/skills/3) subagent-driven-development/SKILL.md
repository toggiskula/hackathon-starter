---
name: subagent-pipeline
description: Use when executing implementation plans with independent tasks in the current session
---

# Subagent Pipeline

Execute plan by dispatching fresh subagent per task, with two-stage review after each: spec compliance review first, then code quality review.

**Core principle:** Fresh subagent per task + two-stage review (spec then quality) = high quality, fast iteration

## When to Use

- You have an implementation plan with multiple tasks
- Tasks are mostly independent
- You want to stay in this session (not hand off to parallel session)

## The Process

1. Read plan, extract all tasks with full text, note context, create TodoWrite
2. For each task:
   a. Dispatch implementer subagent with full task text + context
   b. Implementer asks questions if unclear, then implements + tests + commits
   c. Dispatch spec reviewer: verify code matches spec (nothing more, nothing less)
   d. If spec issues found: implementer fixes, reviewer re-reviews
   e. Dispatch code quality reviewer: verify code is clean + tested + maintainable
   f. If quality issues found: implementer fixes, reviewer re-reviews
   g. Mark task complete
3. After all tasks: dispatch final code reviewer for entire implementation

## Prompt Templates

See companion files in this skill folder:
- `implementer-prompt.md` - Dispatch implementer subagent
- `spec-reviewer-prompt.md` - Dispatch spec compliance reviewer subagent
- `code-quality-reviewer-prompt.md` - Dispatch code quality reviewer subagent

## Key Rules

**Never:**
- Skip reviews (spec compliance OR code quality)
- Dispatch multiple implementation subagents in parallel (conflicts)
- Make subagent read plan file (provide full text instead)
- Start code quality review before spec compliance passes
- Accept "close enough" on spec compliance

**If subagent asks questions:**
- Answer clearly and completely
- Provide additional context if needed
- Don't rush them into implementation

**If reviewer finds issues:**
- Implementer fixes them
- Reviewer reviews again
- Repeat until approved

## Advantages

- Fresh context per task (no confusion from earlier work)
- Two-stage review catches real bugs
- Subagents follow TDD naturally
- Questions surfaced before work begins, not after
- Catches issues early (cheaper than debugging later)
