#!/usr/bin/env bash
# Claude Code hook (SessionStart, Stop): shows the session title in the herdr
# sidebar. The title is word-wrapped into the $title1..$title3 pane tokens that
# dot_config/herdr/config.toml renders as rows; overflow ends in "…".

width=22
max_lines=3

[ "${HERDR_ENV:-}" = 1 ] && [ -n "${HERDR_PANE_ID:-}" ] || exit 0
command -v herdr >/dev/null || exit 0

transcript=$(jq -r '.transcript_path // empty')
[ -f "$transcript" ] || exit 0

# A /rename name wins over the generated title; the latest record of each counts.
title=$(grep -h '"type":"agent-name"' "$transcript" | tail -n 1 | jq -r '.agentName // empty')
[ -n "$title" ] || title=$(grep -h '"type":"ai-title"' "$transcript" | tail -n 1 | jq -r '.aiTitle // empty')

mapfile -t lines < <(printf '%s\n' "$title" | fold -s -w "$width" | sed 's/ *$//')
if [ "${#lines[@]}" -gt "$max_lines" ]; then
  last=${lines[max_lines - 1]:0:width-1}
  lines[max_lines - 1]="${last% }…"
fi

args=()
for ((i = 0; i < max_lines; i++)); do
  if [ -n "${lines[i]:-}" ]; then
    args+=(--token "title$((i + 1))=${lines[i]}")
  else
    args+=(--clear-token "title$((i + 1))")
  fi
done

herdr pane report-metadata "$HERDR_PANE_ID" --source claude-session-title --agent claude "${args[@]}" >/dev/null 2>&1
exit 0
