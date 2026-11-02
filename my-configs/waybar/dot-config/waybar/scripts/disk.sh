#!/bin/sh
# Disk usage for a mountpoint, mirroring the old polybar fs modules.
# Outputs Pango markup: <icon> <percent>%  (icon in @fg_alt #7a7a7a).
#
# usage: disk.sh <mountpoint>
#   /home -> house glyph ()   (filesystem-home)
#   *     -> hdd glyph ()     (filesystem-slash)
#
# Bound as waybar "custom/disk-home" and "custom/disk-slash"
# (modules/custom/disk.jsonc, interval 25s).

mount="$1"
case "$mount" in
  /home) icon="" ;;  # nf-fa-home, same as polybar filesystem-home
  *)     icon="" ;;  # nf-fa-hdd, same as polybar filesystem-slash
esac

usage=$(df -P "$mount" | awk 'NR==2 {gsub(/%/,"",$5); print $5}')
echo "<span foreground='#7a7a7a'>${icon}</span> ${usage}%"
