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

Surgically plan your changes. 

Have you been using LLMs and found that you no longer understand your own code? 

This method can help you regain control. 

- Creating `.plan` files at a file by file level keeps your mental model of the codebase intact.
- You don't lose the speed benefit of LLM-assisted development.
- A standards review step ensures each `.plan` meets your conventions at the file level. 
- Small, focused plan files make MR reviews of your plans easy to digest.


## How It Works

1. Create `.plan` files right next to the source file you want to change. `src/app/auth.py` →
   `src/app/auth.plan`. Use plain language, include a code example if you want.
2. Create `.plan` for all the other files that you need to change.
3. Run `/scalpel:plan <description of what you're trying to achieve>` to evaluate your plans. Scalpel will add plans you missed.
4. Review those suggestions.
5. Run `/scalpel:implement` to create the code changes. Scalpel will follow the plan
   exactly.

### Benefits

1. Since you're creating .plans at a file level you maintain a mental model of the program.
2. When you miss something the plan will catch it.
3. Plans aren't giant markdown files or sprawling contexts. Each plan is small and focused on a single file so it's easy to review.
4. MR reviews of the plan files are easy because the plan file is a small contained unit. 

### Where this approach works best

1. You're finding plan mode plans outputs a wall of text that is hard to review and understand.
2. Codebase is large enough that multiple people/plans won't trip over each other.
3. You have a strong idea of the architecture and standards of your project. 
4. You want to personally maintain a high level of understanding of your codebase as it changes rapidly, even though you're not typing it out anymore.
5. You want to easily review plans in an MR before implementation.

### Where this doesn't work

1. You don't care about code quality and are just letting the LLM write code for you.
2. You're in fully autonomous mode letting the LLMs go wild. Things like Ralph loops.
3. You don't have a strong idea of the architecture and standards of your project and none was implemented.
4. You don't care about maintaining a mental model of your codebase.

## Commands

Three slash commands drive the workflow:

| Command              | What it does                              |
|----------------------|-------------------------------------------|
| `/scalpel:plan`      | Evaluate plan files against the objective |
| `/scalpel:implement` | Apply plan files to source files          |

## Workflow

### 1. Create `.plan` files

For each file that needs to change, create a `.plan` file next to it:

You can specify plans lazily; Scalpel will normalize them automatically when you run `/scalpel:plan`.

Lazy:
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

The `file` field names the target. The `type` field is optional; if omitted, it defaults to `modify`. If the target file does not exist, Scalpel will create it.


### 2. Evaluate your plans

```

/scalpel:plan <optional description of your objective or sub-task>

```

Scalpel reads all `.plan` files, checks them against your project standards (`AGENTS.md` / `CLAUDE.md`), flags anything misaligned or missing, and suggests additional plan files you may need.

Iterate on your `.plan` files until the evaluation is clean.

### 3. Implement

```

/scalpel:implement

```

Scalpel applies every `.plan` file to its target, one at a time, following the plan exactly. If a plan conflicts with a project standard or another plan, it stops and surfaces the conflict before continuing. It will not resolve conflicts on its own.

## Installation

### Claude Code

```bash
/plugin install scalpel@git+https://github.com/Banyango/scalpel.git
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

