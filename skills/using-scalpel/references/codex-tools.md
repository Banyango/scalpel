# Codex / Copilot CLI Tool Mapping

Skills speak in actions. On Codex / GitHub Copilot CLI these resolve to the tools below.

| Action | Codex tool |
|---|---|
| Read a file | `read_file` |
| Create / edit a file | `write_file` |
| Run a shell command | `shell` |
| Search file contents | `grep` |
| Find files by name | `find_files` |
| Fetch a URL | `fetch` |
| Invoke a skill | native skill loading |
| Dispatch a subagent | `task` |
| Task tracking | `add_task`, `complete_task` |

## Instructions File

When a skill mentions "your instructions file": on Codex this is **`AGENTS.md`**.
