#!/bin/sh
# llama-server status icon for polybar (tail mode)
#   running  -> green 󰧑
#   stopped  -> dim gray 󰧑
# Blocks and re-prints the icon whenever the service state changes.
# Left click: toggle start/stop.

emit() {
    if systemctl --user is-active --quiet llama-server; then
        printf '%%{F#5af78e}󰧑 %%{F-}\n'
    else
        printf '%%{F#7a7a7a}󰧑 %%{F-}\n'
    fi
}

if [ "$1" = "toggle" ]; then
    if systemctl --user is-active --quiet llama-server; then
        systemctl --user stop llama-server
    else
        systemctl --user start llama-server
    fi
    exit 0
fi

# print initial state, then watch for changes
last=$(systemctl --user is-active llama-server)
emit
while true; do
    sleep 2
    cur=$(systemctl --user is-active llama-server)
    if [ "$cur" != "$last" ]; then
        last=$cur
        emit
    fi
done
