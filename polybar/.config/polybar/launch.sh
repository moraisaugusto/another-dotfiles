#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar & killall -q insync

# Wait until the processes have been shut down
#while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
polybar --reload top &
insync start &
#polybar bottom &
#polybar top-left &
#polybar top-up &


