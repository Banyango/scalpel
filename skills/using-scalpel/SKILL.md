---
name: using-scalpel
description: Use at the start of any session - establishes how to find and use Scalpel skills before responding to the user
---

# Using Scalpel

Scalpel is a cross-provider skills plugin. Skills are loaded on demand — **never read skill files manually** with file tools. Always use your platform's native skill-loading mechanism.

## How to Load Skills

| Platform | How to invoke a skill |
|---|---|
| **Claude Code** | `Skill` tool |
| **Cursor** | `skill` tool |
| **Codex / Copilot CLI** | skills load natively |
| **Gemini CLI** | `activate_skill` tool |
| **OpenCode** | native `skill` tool |
| **Kimi Code** | native `Skill` tool |

## The Rule

**Check for a relevant skill BEFORE taking any action or asking any question.** A 1% chance of relevance is enough — invoke the skill, then decide if it applies.

```
User message → Is there a skill for this? → Yes: invoke it → Follow the skill
                                           → No: respond normally
```

## Workflow

Scalpel separates planning from implementation. The typical flow:

### 1. Create `.plan` files

For each file that needs to change, create a `.plan` file next to it with the same base name:

```
src/app/auth.py   →   src/app/auth.plan
```

Copy `skills/plan/plan.template.md` as a starting point. Fill in the `file` field and describe the change under `## Change`.

### 2. Evaluate your plans

If you defined a feature:
```
/scalpel:plan
```

If you're scoping to a smaller change within the feature, or skipped `/scalpel:feature`:
```
/scalpel:plan <describe the specific change>
```

Scalpel reads your `.plan` files, checks them against the feature objective and project standards (`AGENTS.md` / `CLAUDE.md`), flags misalignments, and suggests plan files you may have missed. Iterate on your `.plan` files until you're satisfied.

### 3. Implement

```
/scalpel:implement
```

Scalpel applies every `.plan` file to its target. It follows the plan exactly. If anything conflicts with a project standard or another plan, it stops and asks before proceeding. It will not improvise.

---

## Available Skills

- **using-scalpel** — this skill; loaded at session start
- **feature** (`/scalpel:feature`) — interrogate and record the feature objective to `.scalpel/change.md`; slash-command only
- **plan** (`/scalpel:plan`) — evaluate all `*.plan` files against the feature objective and project standards, suggest gaps; slash-command only
- **implement** (`/scalpel:implement`) — apply all `.plan` files to their target source files; slash-command only
- **example-workflow** — template showing how Scalpel skills are structured


## Platform Tool Mapping

Skills speak in platform-neutral actions. See the appropriate reference file for how each action maps to your platform's tools:

- Claude Code → [claude-code-tools.md](references/claude-code-tools.md)
- Cursor → [cursor-tools.md](references/cursor-tools.md)
- Codex → [codex-tools.md](references/codex-tools.md)
- Gemini CLI → [gemini-tools.md](references/gemini-tools.md)

## Instruction Priority

1. **User's explicit instructions** (CLAUDE.md, AGENTS.md, direct requests) — highest
2. **Scalpel skills** — override default behavior where they conflict
3. **Default system prompt** — lowest

If the user says "don't use X workflow" and a skill says "always use X", follow the user.
