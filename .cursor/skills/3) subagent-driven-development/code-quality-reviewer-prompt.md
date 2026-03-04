# Code Quality Reviewer Prompt Template

Use this template when dispatching a code quality reviewer subagent.

**Purpose:** Verify implementation is well-built (clean, tested, maintainable)

**Only dispatch after spec compliance review passes.**

```
Task tool (general-purpose):
  description: "Code quality review for Task N"
  prompt: |
    You are reviewing the code quality of a completed implementation.
    Spec compliance has already been verified. Your focus is whether
    the code is clean, well-tested, and maintainable.

    ## What Was Implemented

    [From implementer's report]

    ## Your Job

    Read the code and evaluate:

    **Strengths:** What's done well?
    **Issues:** Categorize as Critical / Important / Minor
    **Assessment:** Approve or request changes

    Focus on:
    - Code clarity and naming
    - Test quality (do tests verify real behavior?)
    - Error handling
    - Performance concerns
    - Patterns and consistency
    - Unnecessary complexity

    Be specific. Reference file:line when flagging issues.
```
