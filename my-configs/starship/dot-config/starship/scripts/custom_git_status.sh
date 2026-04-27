#!/usr/bin/env zsh

# 1. Check if in a git repo
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    exit 0
fi

# 2. Get Branch Name and Raw Status
BRANCH=$(git branch --show-current)
# Fallback for detached HEAD
[[ -z "$BRANCH" ]] && BRANCH=$(git rev-parse --short HEAD 2>/dev/null)

# 2. Get Raw Status
STATUS=$(git status --porcelain 2>/dev/null)
# Count specific states
MODIFIED=$(echo "$STATUS" | grep -c '^.M')
DELETED=$(echo "$STATUS" | grep -c '^.D')
UNTRACKED=$(echo "$STATUS" | grep -c '??')
STAGED=$(echo "$STATUS" | grep -c '^[ADMR]')
CONFLICTS=$(echo "$STATUS" | grep -c '^UU')

# 3. Determine Color Logic
# If there are modifications, deletions, or conflicts -> RED
if [[ $MODIFIED -gt 0 || $DELETED -gt 0 || $CONFLICTS -gt 0 || $UNTRACKED -gt 0 ]]; then
    BG="215" # Red
    FG="0"  # White text
else
    BG="71" # Yellow
    FG="0"   # Black text
fi

# 4. Build Output String
# Start with the branch name and a separator icon (e.g., )
OUTPUT=" $BRANCH "
[[ $CONFLICTS -gt 0 ]] && OUTPUT+="$CONFLICTS "
[[ $MODIFIED -gt 0 ]]  && OUTPUT+="󱇬 "
[[ $STAGED -gt 0 ]]    && OUTPUT+="󰝒 "
[[ $DELETED -gt 0 ]]   && OUTPUT+=" "
[[ $UNTRACKED -gt 0 ]] && OUTPUT+=" "

# 5. Ahead/Behind check
AHEAD=$(git rev-list --count @{u}..HEAD 2>/dev/null)
BEHIND=$(git rev-list --count HEAD..@{u} 2>/dev/null)
[[ $AHEAD -gt 0 ]]  && OUTPUT+="⇡$AHEAD"
[[ $BEHIND -gt 0 ]] && OUTPUT+="⇣$BEHIND"

# 6. Render with your slanted shapes
# Note: we use -n to avoid trailing spaces
if [[ -n $(echo $OUTPUT | xargs) ]]; then
    printf "\033[38;5;${BG}m\033[48;5;${BG};38;5;${FG};1m %s \033[0m\033[38;5;${BG}m\033[0m" "$(echo $OUTPUT | xargs)"
fi
