---
name: code-simplifier
description: Simplifies and refines recently modified code for clarity, consistency, and maintainability while preserving all functionality. Use when asked to simplify, clean up, or refine code, or after implementing a feature when a polish pass is requested.
---

# Code Simplifier

Clean up Ai code slop. Refine recently modified code for clarity, consistency, and maintainability without changing what the code does. 

## Scope

**Default**: Only refine code modified in the current session.
**If asked to go broader**: Apply to the specified files or scope.

## Refinement Process

1. Identify recently modified sections
2. Analyze for clarity, consistency, and complexity issues
3. Apply the rules below
4. Verify all functionality is unchanged
5. Document only significant changes that affect understanding

## Rules

### Always do

- Reduce unnecessary nesting and complexity
- Eliminate redundant code and abstractions
- Improve variable and function names for clarity
- Consolidate related logic
- Remove comments that only restate what the code already makes obvious (e.g. `// increment counter` above `i++`)
- Preserve: "why" comments, trade-off explanations, workaround notes, TODOs, API contracts, and anything that explains non-obvious intent
- Apply project-specific naming conventions and style rules

### Never do

- Change what the code does -- preserve all behavior, outputs, and features
- Combine too many concerns into a single function
- Remove abstractions that genuinely improve organization
- Optimize for fewer lines at the cost of readability
- Use nested ternaries -- prefer `if/else` chains or `switch` statements for multiple conditions
- Make the code harder to debug or extend

### Balance

Clarity over brevity. Explicit code is usually better than compact code. Avoid over-clever solutions.

## Language-Specific Defaults

Apply these unless the project has its own conventions (which always win):

**TypeScript/JavaScript**
- ES modules with sorted imports and file extensions
- `function` keyword preferred over arrow functions for top-level functions
- Explicit return types on top-level functions
- Explicit React `Props` types

**C# / .NET**
- File-scoped namespaces (`namespace Foo;`)
- `nameof()` over string literals
- `StringComparison.Ordinal` / `OrdinalIgnoreCase` for string comparisons
- Remove unused `using` statements

**Go**
- `gofmt` formatting
- Error handling with explicit `if err != nil` checks
- Short variable names for small scopes, descriptive for larger ones

## Output

After simplification, briefly note what changed and why -- but only if the changes are non-obvious. Skip the narration for routine cleanup.
