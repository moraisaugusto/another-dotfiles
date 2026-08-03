#!/usr/bin/env sh

# # Load environment variables so Polybar and child processes inherit HiDPI settings
# if [ -f "$HOME/.xprofile" ]; then
#     . "$HOME/.xprofile"
# fi

# Terminate already running bar instances
killall -q polybar & killall -q insync

# Launch bar1 and bar2 - GDK_SCALE=1 fixes font issues for pavcontrol
GDK_SCALE=1 polybar --reload top &
insync start &
#polybar bottom &
#polybar top-left &
#polybar top-up &
