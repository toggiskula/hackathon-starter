---
name: adversarial-review
description: "Launch hostile review agents to attack a design from multiple angles before building. Use when a plan or Intent.md exists and you want to find flaws before implementation."
---

# Adversarial Review

Dispatch 3 parallel hostile review agents to attack a design document. Each agent focuses on a different angle. They are not polite. They find what will break, what will frustrate users, and what is over-engineered. The findings reshape the design before a single line of code is written.

## When to Use

- After an Intent.md or design document exists
- Before starting implementation
- When the project is significant enough to warrant ~30 minutes of review

## The 3 Reviewers

| Reviewer | Focus | Finds |
|---|---|---|
| **Technical Feasibility** | Can this actually be built as described? | API limitations, undocumented behavior, integration risks, performance problems, security gaps |
| **UX / Product** | Will users actually want and use this? | Interaction model flaws, first-run friction, missing states, competitive positioning, expectation mismatches |
| **Architecture / Scope** | Is this the right level of complexity? | Over-engineering, unnecessary abstractions, simpler alternatives, scope creep, premature optimization |

## Process

### Step 1: Read the Design Document

Read the Intent.md, design doc, or plan file. Understand what is being built, the architecture, key decisions, and scope boundaries.

### Step 2: Dispatch 3 Hostile Agents

Launch all 3 agents in parallel using the Task tool. Each agent MUST:
- Be explicitly told to be hostile and direct
- Receive the full design document text (do not make them read files)
- Return findings with severity ratings: CRITICAL / HIGH / MEDIUM / LOW
- Provide specific, actionable issues (not vague concerns)

#### Agent 1: Technical Feasibility

```
You are a HOSTILE technical reviewer. Your job is to find every flaw,
risk, and false assumption in this design. Be direct and brutal.

[PASTE FULL DESIGN DOCUMENT]

Attack from a TECHNICAL FEASIBILITY perspective:
1. Integration risks - do the APIs/tools actually work as described?
2. Process management - what happens when things hang, crash, or race?
3. Platform risks - OS-specific issues, permissions, compatibility?
4. Data flow - where does data get lost, corrupted, or stuck?
5. Dependencies - what undocumented behavior will bite you?

Return findings with severity ratings (CRITICAL/HIGH/MEDIUM/LOW).
```

#### Agent 2: UX / Product

```
You are a HOSTILE product/UX reviewer. Your job is to find every
usability problem and conceptual flaw. Be direct.

[PASTE FULL DESIGN DOCUMENT]

Attack from a UX AND PRODUCT perspective:
1. Interaction model - does the metaphor match the actual behavior?
2. First-run experience - what causes dropout or confusion?
3. Error states - what happens when things go wrong for the user?
4. Mental model - does the user understand what the system is doing?
5. Competitive positioning - why would someone use this over alternatives?

Return findings with severity ratings (CRITICAL/HIGH/MEDIUM/LOW).
```

#### Agent 3: Architecture / Scope

```
You are a HOSTILE architecture reviewer and scope cop. Find
over-engineering, scope creep, and unnecessary complexity. Be ruthless.

[PASTE FULL DESIGN DOCUMENT]

Attack from an ARCHITECTURE AND SCOPE perspective:
1. Is the tech stack justified? Could something simpler work?
2. Is the structure premature? Are you designing for v10 instead of v1?
3. File/module count - is this actually "simple"?
4. Dependencies - are you pulling in libraries for things achievable in 30 lines?
5. Is the framing honest? Does the product match its positioning?

For each issue, suggest a simpler alternative if one exists.
Return findings with severity ratings (CRITICAL/HIGH/MEDIUM/LOW).
```

### Step 3: Synthesize Findings

After all 3 agents return, create a synthesis:

1. **Must-Fix (CRITICAL + HIGH)**: Issues that would cause real failure. These change the design.
2. **Should-Consider (MEDIUM)**: Issues that matter but can be addressed incrementally.
3. **Noted (LOW)**: Valid points that don't block v1.

### Step 4: Update the Design Document

Revise the Intent.md or design doc to address all CRITICAL and HIGH findings.

### Step 5: Build Guardrail Rules

Convert findings into `.cursor/rules/` files that constrain development and prevent mistakes.

## Severity Guide

| Severity | Definition | Action |
|---|---|---|
| CRITICAL | Will cause failure on day 1 | Must fix before implementation |
| HIGH | Will cause significant problems within first week | Must fix before shipping |
| MEDIUM | Will cause friction but won't block usage | Address in v1 if time allows |
| LOW | Valid concern but not blocking | Document for future consideration |
