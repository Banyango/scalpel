<p align="center">
  <picture>
    <img src="assets/logo.jpg" width="256" alt="Scalpel">
  </picture>
</p>

<h1 align="center">Scalpel</h1>

<p align="center">
  <em>Writing code is dead. Understanding it is not.</em>
</p>

<p align="center">
  <img src="https://img.shields.io/github/stars/Banyango/scalpel?style=flat-square&color=111111&label=stars" alt="Stars">
  <img src="https://img.shields.io/github/v/release/Banyango/scalpel?style=flat-square&color=111111&label=release" alt="Release">
  <img src="https://img.shields.io/badge/license-MIT-111111?style=flat-square" alt="MIT license">
  <img src="https://skills.sh/b/Banyango/scalpel" alt="Skills.sh">
</p>

> “The job is no longer typing code; it is maintaining enough understanding to trust what was typed.”

When you aren't vibe coding and need to make sure your code changes are right, use Scalpel to surgically plan your
changes.

- Create `.plan` files right beside the real file for a much clearer picture on what the AI is planning on doing.
- Small individual files make changes easier to contextualize than large Markdown or HTML documents.
- A standards review step ensures each and every `.plan` meets your AGENT.md conventions.
- Working with small, focused plan files make MR reviews of your plans easy to digest by others.

## How It Works

You can have AI create the `.plan` files or write them manually.

### Have AI create the plans

1. Run `/scalpel:plan <the change you want to make>` to create `.plan` files.
2. Review the created `.plan` files.
3. Make any necessary adjustments to the plans.
    1. Chat with the AI to clarify or refine the plans.
    2. Changes are easy to understand because each plan is small and focused on a single file.
    3. You could push a draft MR to see what others think of the plans before implementing them.
4. If you're happy with the plans, run `/scalpel:implement`. The agent will exactly follow the plans to make the code
   changes.

### Create the plans manually

1. Create a `.plan` file next to each source file you want to change. For example, `src/app/auth.plan` targets
   `src/app/auth.py` when you specify that path in the `file` field. Use plain language and include a code example if
   you want.
2. Create `.plan` files for all the other files that need to change.
3. Run `/scalpel:plan <description of what you're trying to achieve>` to evaluate your plans. Scalpel will add any
   missing plans.
4. Review the findings and any added plans.
5. If you're happy with the plans, run `/scalpel:implement` to apply the code changes. Scalpel will follow the plans
   exactly.

### Benefits

1. Planning is much easier to comprehend. You see exactly what the change will be.
2. If you manually create `.plan` files and miss a required change, `/scalpel:plan` will identify the gap and add the
   missing plan.
3. Plans aren't giant markdown files or sprawling contexts. Each plan is small and focused on a single file so it's easy
   to review.
4. MR reviews of plan files are easy because each plan is a small, focused unit.

### Where this approach works best

1. You find that plan mode produces a wall of text that is hard to review and understand.
2. You want to plan a change before asking the LLM to implement it.
3. You want to personally maintain a level of understanding of your codebase as it changes rapidly, even though you're
   not typing it out anymore.
4. You want to easily review plans in an MR before implementation.

## Commands

Two slash commands drive the workflow:

| Command              | What it does                           |
|----------------------|----------------------------------------|
| `/scalpel:plan`      | Evaluate plans and create missing ones |
| `/scalpel:implement` | Apply plan files to source files       |

## Workflow

### 1. Create `.plan` files

For each file that needs to change, create a `.plan` file next to it:

You can write plans in plain language; Scalpel will normalize them automatically when you run `/scalpel:plan`.

Minimal:

```markdown
Add a login function
```

With full structure:

```markdown
---
file: src/app/auth.py
type: modify
---

## Summary

Add GitHub OAuth login so users can authenticate without a password.

## Content

/```python
def login_with_github(code: str) -> User:
    token = exchange_code(code)
    profile = fetch_github_profile(token)
    return User.from_github(profile)
/```

## Key Details

- `exchange_code` is already implemented in `oauth.py` — reuse it, don't rewrite.
- Returns a `User` object; raises `AuthError` on failure.

## Acceptance Criteria

- [ ] A valid OAuth code returns a populated `User` object.
- [ ] An invalid code raises `AuthError`.
```

The `file` field names the target. The `type` field is optional; if omitted, it defaults to `modify`. If the target file
does not exist, Scalpel will create it.

### 2. Evaluate your plans

```

/scalpel:plan <optional description of your objective or sub-task>

```

Scalpel reads all `.plan` files, checks them against your project standards (`AGENTS.md` / `CLAUDE.md`), flags anything
misaligned or missing, and creates any missing plan files needed to meet your objective.

Iterate on your `.plan` files until the evaluation is clean.

### 3. Implement

```

/scalpel:implement

```

Scalpel applies every `.plan` file to its target, one at a time, following the plan exactly. If a plan conflicts with a
project standard or another plan, it stops and surfaces the conflict before continuing. It will not resolve conflicts on
its own.

## Installation

### Claude Code

```bash
/plugin marketplace add Banyango/scalpel
/plugin install scalpel@scalpel-dev
```

Skills are available as `/scalpel:plan` and `/scalpel:implement`.

### Cursor

Add to your `.cursor/plugins.json`:

```json
{
  "plugins": [
    "git+https://github.com/Banyango/scalpel.git"
  ]
}
```

### GitHub Codex / Copilot CLI

Add to your Codex plugin configuration:

```json
{
  "plugins": [
    "git+https://github.com/Banyango/scalpel.git"
  ]
}
```

### OpenCode

Add to your `opencode.json`:

```json
{
  "plugin": [
    "scalpel@git+https://github.com/Banyango/scalpel.git"
  ]
}
```

See `.opencode/INSTALL.md` for full OpenCode setup instructions.

### Gemini CLI

Load `GEMINI.md` from this repo into your project root, or import it from your existing `GEMINI.md`.

### Skills.sh

```bash
npx skills add Banyango/scalpel
```

## Project Standards

Scalpel respects your project's documented conventions. During `/scalpel:plan` and `/scalpel:implement`, it reads:

- `AGENTS.md`
- `CLAUDE.md`
- `docs/ARCHITECTURE.md` (or any `docs/arch*`)

It only enforces what is explicitly written in those files. It will not invent patterns or apply external conventions.

## `.plan` File Reference

```markdown
---
file: path/to/target/file.py   # required — the file to modify
type: add | modify | move | delete
---

## Summary

Why this change is being made.

## Content

/```language
// The code to be added or changed.
/```

## Key Details

- Non-obvious constraints, invariants, or decisions the implementer needs to know.
- Edge cases to handle.

## Acceptance Criteria

- [ ] Observable outcome that confirms the change is correct.
```

## License

[MIT](LICENSE).

### Logo

<a href="https://www.vecteezy.com/free-vector/scalpel">Scalpel Vectors by Vecteezy</a>

