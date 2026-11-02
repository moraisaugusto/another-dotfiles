#!/bin/sh
# Display the current default sink icon + volume, polybar-style (per-sink icons).
# Icons copied from the polybar pipewire-custom outputs map.

ICON_HD4="󰓃"     # Audioengine HD4
ICON_OTHER="󰟁" # any other sink (polybar's OWC icon)

sink=$(pactl info | sed -n 's/^Default Sink: //p')

case "$sink" in
  *Audioengine_HD4*) icon="$ICON_HD4" ;;
  *)                 icon="$ICON_OTHER" ;;
esac

vol=$(pamixer --get-volume-human 2>/dev/null)
[ -z "$vol" ] && vol=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')

echo "$icon $vol"
