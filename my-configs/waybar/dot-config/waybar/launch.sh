#!/bin/sh
# Restart waybar cleanly (kill + relaunch) to pick up config/style changes.
killall -q waybar
while pgrep -x waybar >/dev/null; do sleep 0.1; done
waybar &
