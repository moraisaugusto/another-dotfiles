#!/bin/sh
#
# Apply the single UI_SCALE (from ~/.config/scaling.env) to every sway output.
#
# Invoke from the sway config with:
#     exec ~/.config/sway/apply-scale.sh
#
# Sway/Wayland uses an output scale factor instead of GDK_SCALE/Xft.dpi.

[ -f "$HOME/.config/scaling.env" ] && . "$HOME/.config/scaling.env"

swaymsg -t get_outputs -r |
  jq -r '.[].name' |
  while IFS= read -r output; do
      swaymsg output "$output" scale "$UI_SCALE"
  done
