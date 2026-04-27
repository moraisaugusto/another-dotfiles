#!/usr/bin/env bash

# 1. Configuration
TRUNCATE_LEVEL=4  # Depth at which we start showing ~/../folder

# 2. Get current path and count depth
# We use realpath to ensure we have the absolute path
FULL_PATH=$(realpath "$PWD")
DEPTH=$(echo "$FULL_PATH" | tr -cd '/' | wc -c)

# 3. Handle the display logic
if [[ "$FULL_PATH" == "$HOME" ]]; then
    # Case: Exactly Home
    DISPLAY_PATH="~/"
    SYMBOL=""
elif [[ "$FULL_PATH" == "$HOME/"* ]] && [ "$DEPTH" -ge "$TRUNCATE_LEVEL" ]; then
    # Case: Inside Home and Deep enough to truncate
    # Shows ~/../current_folder
    DISPLAY_PATH="~/../$(basename "$FULL_PATH")"
    SYMBOL=""
else
    # Case: Shallow path or outside Home
    # Replaces /home/user with ~
    DISPLAY_PATH=$(echo "$FULL_PATH" | sed "s|^$HOME|~|")
    
    # Decide symbol based on depth
    if [ "$DEPTH" -le 2 ]; then
        SYMBOL=""
    else
        SYMBOL=""
    fi
fi

# 4. Final Output
echo -e "\033[44;30;1m $DISPLAY_PATH \033[0m\033[34m$SYMBOL\033[0m"
