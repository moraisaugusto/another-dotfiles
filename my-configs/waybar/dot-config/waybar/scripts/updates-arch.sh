#!/bin/sh
# Pending system updates (Arch + AUR), like polybar updates-arch-combined.
#   arch count = checkupdates | wc -l
#   aur  count = yay -Qum     | wc -l
# Prints "<arch> <arch-glyph> <aur>" when total > 0, otherwise nothing.
# Bound as waybar "custom/updates" (modules/custom/updates.jsonc, interval 600s).

if ! updates_arch=$(checkupdates 2> /dev/null | wc -l ); then
    updates_arch=0
fi

if ! updates_aur=$(yay -Qum 2> /dev/null | wc -l); then
    updates_aur=0
fi

updates=$(("$updates_arch" + "$updates_aur"))

if [ "$updates" -gt 0 ]; then
    echo "$updates_arch  $updates_aur"
else
    echo ""
fi
