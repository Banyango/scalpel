# Gemini CLI Tool Mapping

Skills speak in actions. On Gemini CLI these resolve to the tools below.

| Action | Gemini CLI tool |
|---|---|
| Read a file | `read_file` |
| Create / edit a file | `write_file` |
| Run a shell command | `run_shell_command` |
| Search file contents | `search_file_content` |
| Find files by name | `find_files` |
| Fetch a URL | `web_fetch` |
| Search the web | `google_web_search` |
| Invoke a skill | `activate_skill` |
| Dispatch a subagent | subagent spawning |
| Task tracking | `save_memory` / context |

## Instructions File

When a skill mentions "your instructions file": on Gemini CLI this is **`GEMINI.md`**.
