#!/usr/bin/env bash

input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // "Unknown"')
effort=$(echo "$input" | jq -r '.effort.level // empty')
thinking=$(echo "$input" | jq -r '.thinking.enabled // false')
session=$(echo "$input" | jq -r '.session_name // empty')
project=$(echo "$input" | jq -r '.workspace.project_dir // empty' | xargs basename 2>/dev/null)

lines_added=$(echo "$input" | jq -r '.cost.total_lines_added // 0')
lines_removed=$(echo "$input" | jq -r '.cost.total_lines_removed // 0')

total_tokens=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
ctx_size=$(echo "$input" | jq -r '.context_window.context_window_size // 200000')
ctx_used_k=$(echo "$total_tokens $ctx_size" | awk '{printf "%.0fk/%.0fk", $1/1000, $2/1000}')

five_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_reset=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
seven_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
seven_reset=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')

time_remaining() {
  local ts=$1
  [ -z "$ts" ] && return
  local now diff h m d
  now=$(date +%s)
  diff=$((ts - now))
  if [ "$diff" -le 0 ]; then
    echo "now"
  elif [ "$diff" -lt 3600 ]; then
    echo "$((diff/60))m"
  elif [ "$diff" -lt 86400 ]; then
    h=$((diff/3600)); m=$(((diff%3600)/60))
    [ "$m" -gt 0 ] && echo "${h}h${m}m" || echo "${h}h"
  else
    d=$((diff/86400)); h=$(((diff%86400)/3600))
    [ "$h" -gt 0 ] && echo "${d}d${h}h" || echo "${d}d"
  fi
}

ORANGE=$'\033[38;5;208m'
CYAN=$'\033[38;5;87m'
YELLOW=$'\033[38;5;220m'
GREEN=$'\033[38;5;82m'
RED=$'\033[38;5;203m'
WHITE=$'\033[97m'
GRAY=$'\033[38;5;245m'
RESET=$'\033[0m'

SEP="${GRAY} | ${RESET}"

# Line 1: Model (effort) | Thinking: On/Off
thinking_val=$( [ "$thinking" = "true" ] && echo "On" || echo "Off" )
model_part="${ORANGE}${model}${RESET}"
[ -n "$effort" ] && model_part="$model_part${GRAY} (${effort})${RESET}"
line1="${model_part}${SEP}${WHITE}Thinking:${RESET} ${GRAY}${thinking_val}${RESET}"

# Line 2: Project | Session | +added/-removed
line2="${CYAN}${project}${RESET}${SEP}${WHITE}${session}${RESET}"
if [ "$lines_added" -gt 0 ] || [ "$lines_removed" -gt 0 ]; then
  line2="$line2${SEP}${GREEN}+${lines_added}${RESET}${GRAY}/${RESET}${RED}-${lines_removed}${RESET}"
fi

# Line 3: Ctx used/total | 5H % reset | 7D % reset
five_reset_str=$(time_remaining "$five_reset")
seven_reset_str=$(time_remaining "$seven_reset")

line3="${YELLOW}${ctx_used_k}${RESET}"
if [ -n "$five_pct" ]; then
  line3="$line3${SEP}${WHITE}5H ${five_pct}%${RESET}"
  [ -n "$five_reset_str" ] && line3="$line3 ${GRAY}${five_reset_str}${RESET}"
fi
if [ -n "$seven_pct" ]; then
  line3="$line3${SEP}${WHITE}7D ${seven_pct}%${RESET}"
  [ -n "$seven_reset_str" ] && line3="$line3 ${GRAY}${seven_reset_str}${RESET}"
fi

printf '%s' "${line1}"$'\n'"${line2}"$'\n'"${line3}"
