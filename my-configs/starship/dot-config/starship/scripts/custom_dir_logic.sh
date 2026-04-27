#!/usr/bin/env bash

DEPTH=$(pwd | tr -cd '/' | wc -c)

# 2. Strip the leading space that Starship module adds by default
RAW=$(STARSHIP_CONFIG=/dev/null starship module directory --path .)
TRUNC_PATH=$(echo "../$RAW" | sed 's/\x1b\[[0-9;]*m//g' | xargs)


if [ "$DEPTH" -le 2 ]; then
    # FORMAT 1: No Truncation (e.g., Blue background, simple arrow)
    echo -e "\033[44;30;1m $(pwd | sed "s|^$HOME|~|")\033[0m\033[34m\033[0m"
else
    # FORMAT 2: Truncated (e.g., Different colors or extra symbols)
    echo -e "\033[44;30;1m $TRUNC_PATH \033[0m\033[34m\033[0m"
fi
