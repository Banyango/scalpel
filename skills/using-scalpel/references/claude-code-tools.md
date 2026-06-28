# Claude Code Tool Mapping

Skills speak in actions. On Claude Code these resolve to the tools below.

| Action | Claude Code tool |
|---|---|
| Read a file | `Read` |
| Create a new file | `Write` |
| Edit a file | `Edit` |
| Run a shell command | `Bash` |
| Search file contents | `Grep` |
| Find files by name | `Glob` |
| Fetch a URL | `WebFetch` |
| Search the web | `WebSearch` |
| Invoke a skill | `Skill` |
| Dispatch a subagent | `Agent` |
| Multiple parallel dispatches | Multiple `Agent` calls in one response |
| Task tracking ("create a todo", "mark complete") | `TaskCreate`, `TaskUpdate`, `TaskList`, `TaskGet` |

## Instructions File

When a skill mentions "your instructions file": on Claude Code this is **`CLAUDE.md`**. Claude Code walks up the directory tree and concatenates every `CLAUDE.md` it finds.

| Scope | Location |
|---|---|
| Project (team-shared) | `./CLAUDE.md` |
| User global | `~/.claude/CLAUDE.md` |
| Local-private (gitignored) | `./CLAUDE.local.md` |

## Personal Skills Directory

User-level skills live at `~/.claude/skills/`. Each skill is a subdirectory containing a `SKILL.md` with `name` and `description` frontmatter.
