#!/bin/bash
# Runs at Claude Code session start. Outputs a system prompt fragment that
# instructs Claude to load the using-scalpel skill before responding.
cat <<'EOF'
<system>
You have the Scalpel skills plugin installed. Before responding to the user's
first message, invoke the "using-scalpel" skill to learn how to find and use
your available skills.
</system>
EOF
