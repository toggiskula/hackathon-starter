# Hackathon Starter

Clone this repo, open it in Cursor, and start a new chat session. The agent is pre-configured to help you build something from scratch in one hour.

## Quick Start

```bash
git clone https://github.com/toggiskula/hackathon-starter.git my-project
cd my-project
```

Open in Cursor. Start a new Agent session. The agent will greet you and ask what you want to build.

## What's Included

This repo ships with a set of AI workflow skills pre-installed in `.cursor/skills/`:

| Skill | What it does |
|-------|-------------|
| **brainstorming** | Structured Q&A to turn a vague idea into a clear design |
| **intent-engineering** | Captures your vision as an Intent.md before any code is written |
| **adversarial-review** | 3 hostile AI agents attack your design to find flaws early |
| **subagent-driven-development** | Parallel AI agents build tasks from your plan with two-stage review |
| **memory-v3-setup** | Persistent memory so the AI remembers what happened between sessions |
| **frontend-design** | Create distinctive, production-grade frontend interfaces with high design quality |

## The Workflow

1. **Brainstorm** - Tell the AI "I want to make something" and answer its questions
2. **Intent.md** - Your vision, structured: what it is, why it matters, what's in scope
3. **Rules** - The agent generates a `.cursor/rules/` file from your intent so it stays on track
4. **Plan** - Break the build into tasks
5. **Build** - Parallel agents implement tasks, reviewers verify quality
6. **Memory** - Run `/handoff` at the end so your next session picks up where you left off

## No Idea? No Problem.

Just open a chat and say:

> "I want to make something. Ask me questions until we know what to build."

The agent handles the rest.

## Already Know What You Want?

Skip the ceremony. Tell the agent what you're building and it will adapt.
