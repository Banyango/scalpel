<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="assets/logo-dark.png">
    <img src="assets/logo.png" width="220" alt="Scalpel">
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
</p>

> “The job is no longer typing code; it is maintaining enough understanding to trust what was typed.”

Surgically plan your changes. 

Have you been using LLMs and found that you no longer understand your own code? That you get the LLM to make a plan, and it seems fine, but once the implementation lands things work but the code fails review? Do you work somewhere that devs are merging at a blazing pace without following standards and the codebase is slowly turning to muck?

This method can help you regain control. 

- Manually creating `.plan` files keeps your mental model of the codebase intact even as it changes rapidly.
- You don't lose the speed benefit of LLM-assisted development.
- A standards review step ensures each plan meets your conventions at the file level. 
- Small, focused plan files make MR reviews easy to digest.

## How It Works

1. Start by creating `.plan` files right next to the source file you want to change. `src/app/auth.py` →
   `src/app/auth.plan`
2. Describe the change you want to make in plain language. Include a code example, if you want.
3. Run `/scalpel:plan <description of what you're trying to achieve>` to evaluate your plans.
4. Scalpel will flag any misalignment and suggest additional plan files you may need.
5. Review those suggestions and iterate.
6. When your plans are clean, run `/scalpel:implement` to apply them to the source files. Scalpel will follow the plan
   exactly.

### Benefits

1. Since you're manually creating .plans at a file level you maintain a mental model of the program.
2. When you miss a standard the plan will catch it and you can update your mental model of the program.
3. Plans aren't giant markdown files or sprawling contexts. Each plan is small and focused on a single file so it's easy to review.
4. MR reviews of the plan files are easy because the plan file is a small contained unit. 

### Where this approach works best

1. You're finding plan mode plans outputs a wall of text that is hard to review and understand.
2. You work on a team (alone is fine too)
3. Codebase is large enough that multiple people/plans won't trip over each other.
4. You have a strong idea of the architecture and standards of your project. 
5. You want to personally maintain a high level of understanding of your codebase as it changes rapidly, even though you're not typing it out anymore.
6. You want to easily review plans in an MR before implementation.

### Where this doesn't work

1. You don't care about code quality and are just letting the LLM write code for you.
2. You're in fully autonomous mode letting the LLMs go wild. Things like Ralph loops.
3. You don't have a strong idea of the architecture and standards of your project and none was implemented.
4. You don't care about maintaining a mental model of your codebase.

## Commands

Three slash commands drive the workflow:

| Command              | What it does                              |
|----------------------|-------------------------------------------|
| `/scalpel:feature`   | Define and lock the objective (optional)  |
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

With frontmatter and description:
```markdown
---
file: src/app/auth.py
type: modify
---

## Change

Add a `login_with_github(code: str) -> User` function that exchanges an OAuth
code for a token, fetches the GitHub user profile, and returns a User object.

```python
def login_with_github(code: str) -> User:
    token = exchange_code(code)
    profile = fetch_github_profile(token)
    return User.from_github(profile)
```

The `file` field names the target. The description tells the agent what to build. A code example pins the implementation shape.
The `type` field is optional; if omitted, it defaults to `modify`. If the target file does not exist, Scalpel will create it.


### 2. Evaluate your plans

```

/scalpel:plan <optional description of your objective or sub-task>

```

Scalpel reads all `.plan` files, checks them against your feature objective and project standards (`AGENTS.md` / `CLAUDE.md`), flags anything misaligned or missing, and suggests additional plan files you may need.

For a scoped sub-task within the broader feature:

```

/scalpel:plan add the token exchange step only

```

Iterate on your `.plan` files until the evaluation is clean.

### 3. Implement

```

/scalpel:implement

```

Scalpel applies every `.plan` file to its target, one at a time, following the plan exactly. If a plan conflicts with a project standard or another plan, it stops and surfaces the conflict before continuing. It will not resolve conflicts on its own.

### Optional: Define the feature

```
/scalpel:feature add OAuth login via GitHub
```

Use the feature skill to create an overarching objective for your plans, instead of relying on the optional description in `/scalpel:plan`. Scalpel will ask clarifying questions, challenge the scope, and write the approved objective to `.scalpel/change.md`. All subsequent plan evaluations reference this file automatically.

It will get cleaned up after `/scalpel:implement` is run.

## Installation

### Claude Code

```bash
/plugin install scalpel@git+https://github.com/Banyango/scalpel.git
```

Skills are available as `/scalpel:feature`, `/scalpel:plan`, and `/scalpel:implement`.

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

## Change

Describe the change in plain language. Include a code example if the
implementation shape matters.
```

## License

[MIT](LICENSE).
