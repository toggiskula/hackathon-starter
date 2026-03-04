# /skills

Show the workflow skills and how to use them.

When this command runs, respond with:

1. A short intro: "Here are the pre-installed workflow skills. They're numbered by the order you'd use them. You can tell me to run any of them, or open `.cursor/skills/` in the file tree to browse."

2. This table:

| Step | Folder in `.cursor/skills/` | What it does | How to invoke |
|------|----------------------------|--------------|---------------|
| 1 | `1) brainstorming` | Turns a vague idea into a clear design through conversation | "Run the brainstorming skill" |
| 1 | `1) intent-engineering` | Captures your vision as a lightweight Intent.md | "Write an Intent.md" |
| 2 | `2) adversarial-review` | 3 hostile AI reviewers attack your design to find flaws early | "Run adversarial review" |
| 3 | `3) subagent-driven-development` | Parallel agents build tasks with two-stage review | "Start building" / "Run subagent dev" |
| 4 | `4) code-simplifier` | Cleans up AI-generated code for clarity and consistency | "Simplify the code" |
| 5 | `5) verification-before-completion` | Proves the code works before claiming done | "Verify before we finish" |
| -- | `frontend-design` | Production-grade web UI components | "Use the frontend design skill" |
| -- | `memorize` | Thorough memory checkpoint | `/memorize` |

3. End with: "Want more? Open `Download skills.html` in `.cursor/skills/` in a browser to browse and install from the full shared library."
