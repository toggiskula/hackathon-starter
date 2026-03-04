# Hackathon Starter

Clone this repo, open it in Cursor, and build something from scratch.

**You can skip any step. Just tell the agent what you want.**

## Quick Start

```bash
git clone https://github.com/toggiskula/hackathon-starter.git my-project
cd my-project
```

Open in Cursor. Press **Cmd+L** to open chat. Make sure you are in **Agent mode** (not Ask mode). Type `/start` or just say hello.

The agent will meet you where you are -- whether you have a clear idea, a vague direction, or nothing at all.

## The Approach

This repo is set up around a structured AI-assisted development workflow:

**Brainstorm -> Intent -> Plan -> Build -> Polish**

Each step exists because it solves a real problem. Brainstorming prevents building the wrong thing. Intent.md gives every agent a shared understanding of what you want. Planning keeps scope realistic. Two-stage review catches bugs that single-pass generation misses.

You will probably experience 3-4 of these steps in an hour, and that is fine. The goal is not to finish. The goal is to see how far you get when you define your ask clearly enough.

1. **Brainstorm** -- tell the AI what interests you, answer its questions, shape the idea together
2. **Intent.md** -- your vision captured in 5-10 lines: what it is, why it matters, constraints
3. **Plan** -- break the build into 2-4 tasks scoped to the time you have
4. **Build** -- parallel AI agents implement tasks, reviewers verify quality after each one
5. **Polish** -- clean up the code, verify it works

## No Idea? No Problem.

Just open chat and say:

> "I want to make something but I don't know what. Help me figure it out."

The agent will brainstorm with you -- one question at a time, no pressure.

You can also explore [QuickCursor](https://github.com/greenqloud/QuickCursor), a complete app built entirely through this same AI workflow. Walk through the code with the agent and see what the process produces. It often sparks ideas.

## Already Know What You Want?

Skip the ceremony. Tell the agent what you are building and it will start immediately.

## What's Included

Pre-installed AI workflow skills in `.cursor/skills/`, numbered by the order you use them:

| Step | Skill | What it does |
|------|-------|-------------|
| 1 | **brainstorming** | Conversational Q&A to turn a vague idea into a clear design |
| 1 | **intent-engineering** | Captures your vision as a lightweight Intent.md |
| 2 | **adversarial-review** | 3 hostile AI agents attack your design to find flaws early (optional) |
| 3 | **subagent-driven-development** | Parallel AI agents build tasks with two-stage review |
| 4 | **code-simplifier** | Refines AI-generated code for clarity and quality |
| 5 | **verification-before-completion** | Proves the code works before claiming done |
| -- | **frontend-design** | Production-grade web UI components (use as needed) |
| -- | **handoff** | Saves session state so your next session picks up where you left off |

Want more skills? Open `Download skills.html` in `.cursor/skills/` to browse and install from the shared library.

## For New Cursor Users

1. **Install Cursor** from [cursor.com](https://cursor.com)
2. **Open this folder** in Cursor (File -> Open Folder)
3. **Open chat** with Cmd+L (Mac) or Ctrl+L (Windows/Linux)
4. **Switch to Agent mode** -- look at the mode selector at the bottom of the chat panel. If it says "Ask", switch it to "Agent".
5. **Type `/start`** or just say hello

## Memory

This repo has a lightweight memory system. The agent reads `HANDOFF.md` at the start of each session to orient itself. At the end, type `/handoff` to save state -- useful if you want to continue later or pass the project to someone else.
