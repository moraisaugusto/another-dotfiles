#!/usr/bin/env zsh

# 1. Check if in a git repo
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    exit 0
fi

# 2. Get Branch Name and Status
BRANCH=$(git branch --show-current)
[[ -z "$BRANCH" ]] && BRANCH=$(git rev-parse --short HEAD 2>/dev/null)

STATUS=$(git status --porcelain 2>/dev/null)

# Optimization: Count using zsh built-in matching on the status string
MODIFIED=$(echo "$STATUS" | grep -c '^.M')
DELETED=$(echo "$STATUS" | grep -c '^.D')
UNTRACKED=$(echo "$STATUS" | grep -c '??')
STAGED=$(echo "$STATUS" | grep -c '^[ADMR]')
CONFLICTS=$(echo "$STATUS" | grep -c '^UU')

# 3. Determine Color Logic
# If there are changes (Dirty), use Yellow. Otherwise (Clean), use Green.
if [[ -n "$STATUS" ]]; then
    BG="215" # YELLOW (Dirty)
    FG="0"   # Black text
else
    BG="71"  # GREEN (Clean)
    FG="0"   # Black text
fi

# 4. Build Output String
OUTPUT=" $BRANCH "
[[ $CONFLICTS -gt 0 ]] && OUTPUT+="$CONFLICTS "
[[ $MODIFIED -gt 0 ]]  && OUTPUT+="󱇬 "
[[ $STAGED -gt 0 ]]    && OUTPUT+="󰝒 "
[[ $DELETED -gt 0 ]]   && OUTPUT+=" "
[[ $UNTRACKED -gt 0 ]] && OUTPUT+=" "

# 5. Ahead/Behind check
# Using @{u} requires an upstream to be set
AHEAD=$(git rev-list --count @{u}..HEAD 2>/dev/null || echo 0)
BEHIND=$(git rev-list --count HEAD..@{u} 2>/dev/null || echo 0)
[[ $AHEAD -gt 0 ]]  && OUTPUT+="⇡$AHEAD"
[[ $BEHIND -gt 0 ]] && OUTPUT+="⇣$BEHIND"

# 6. Render with Slanted Shapes
# Trimming whitespace from output
CLEAN_OUTPUT=$(echo "$OUTPUT" | xargs)

if [[ -n "$CLEAN_OUTPUT" ]]; then
    # \033[38;5;${BG}m      -> The slanted left edge (FG color matches BG of middle)
    # \033[48;5;${BG}...     -> The middle block (Actual BG color)
    # \033[38;5;${BG}m      -> The slanted right edge (FG color matches BG of middle)
    printf "\033[38;5;${BG}m\033[48;5;${BG};38;5;${FG};1m %s \033[0m\033[38;5;${BG}m\033[0m" "$CLEAN_OUTPUT"
fi
