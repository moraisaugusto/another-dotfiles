#!/bin/sh
# waybar disk usage, mirroring the polybar fs modules (icon + percent used)
# usage: disk.sh <mountpoint>

mount="$1"
case "$mount" in
  /home) icon="" ;;  # nf-fa-home, same as polybar filesystem-home
  *)     icon="" ;;  # nf-fa-hdd, same as polybar filesystem-slash
esac

usage=$(df -P "$mount" | awk 'NR==2 {gsub(/%/,"",$5); print $5}')
echo "<span foreground='#7a7a7a'>${icon}</span> ${usage}%"
