#!/usr/bin/env bash

# --- 1. Configuration ---
SYMBOL_MAIN=""

COLOR_YELLOW=215
COLOR_BLUE=4
COLOR_GREEN=2
COLOR_BLACK=30

RESET="\033[0m"
MOVE_LEFT="\033[1D"

# --- 2. Data Acquisition ---
# Capture module output; --path . ensures accuracy within scripts
GIT_OUT=$(starship module custom.git_status --path .)
PY_OUT=$(starship module python --path .)

# --- 3. Logic: Priority Selection ---
if [[ -n "$GIT_OUT" && -n "$PY_OUT" ]]; then
    # Git Repo + Python Environment
    CURRENT_BG=$COLOR_GREEN
elif [[ -n "$GIT_OUT" ]]; then
    # Git Repo only
    CURRENT_BG=$COLOR_YELLOW
else
    # Default (Blue)
    CURRENT_BG=$COLOR_BLUE
fi

# --- 4. Sequence Building ---
# 48;5; is BG, 38;5; is FG. 
# We add a space " " after the sequence so the BG color is visible.
BG_SEQ="\033[48;5;${CURRENT_BG};38;5;${COLOR_BLACK};1m"
ARROW_SEQ="\033[38;5;${CURRENT_BG}m"

# --- 5. Final Output ---
# ${MOVE_LEFT} - Pulls the block back to overlap/align
# ${BG_SEQ}    - Prints the colored background + space
# ${RESET}     - Clears the BG before the arrow starts
# ${ARROW_SEQ} - Colors the arrow to match the previous BG
printf "%b" "${MOVE_LEFT}${BG_SEQ}${RESET}${ARROW_SEQ}${SYMBOL_MAIN}${RESET}"
