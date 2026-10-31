#!/bin/bash

# --- DISPLAY IDENTIFIERS ---
PRIMARY_DISPLAY="DP-3"
SECONDARY_DISPLAY="DP-2"

# --- DISPLAY SETTINGS ---
RESOLUTION="3840x2160"
REFRESH_RATE="100"
SCALE="1"  # Wayland uses scale factor instead of DPI. 2 ≈ 192 DPI on 4K.

# --- WALLPAPER SETTINGS ---
WALLPAPER_DIR="$HOME/GoogleDrive/wallpapers"
PRIMARY_WALLPAPER="$WALLPAPER_DIR/space-exploration.jpg"
SECONDARY_WALLPAPER="$WALLPAPER_DIR/mount.png"

# --- HELPER FUNCTION ---
show_usage() {
    cat << EOF
Usage: $(basename "$0") [MODE]

A display and wallpaper manager for Sway/Wayland.

Available Modes:
  primary      Enable only $PRIMARY_DISPLAY (Main)
  secondary    Enable only $SECONDARY_DISPLAY (Side)
  both         Enable both monitors ($SECONDARY_DISPLAY to the left of $PRIMARY_DISPLAY)
  help         Display this help message

Settings:
  Resolution:  $RESOLUTION
  Refresh:     $REFRESH_RATE Hz
  Scale:       $SCALE
EOF
}

# Basic Check: Ensure wallpaper directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
    notify-send "Display Manager" "Warning: Wallpaper directory not found at $WALLPAPER_DIR"
fi

# Ensure swaybg is not already running (avoid duplicate instances)
pkill -x swaybg 2>/dev/null

case "$1" in
    primary)
        swaymsg "output \"$PRIMARY_DISPLAY\" enable mode ${RESOLUTION}@${REFRESH_RATE}Hz pos 0 0 scale $SCALE transform normal"
        swaymsg "output \"$SECONDARY_DISPLAY\" disable"
        sleep 1
        swaybg -o "$PRIMARY_DISPLAY" -i "$PRIMARY_WALLPAPER" -m fill &
        ;;

    secondary)
        swaymsg "output \"$SECONDARY_DISPLAY\" enable mode ${RESOLUTION}@${REFRESH_RATE}Hz pos 0 0 scale $SCALE transform normal"
        swaymsg "output \"$PRIMARY_DISPLAY\" disable"
        sleep 1
        swaybg -o "$SECONDARY_DISPLAY" -i "$SECONDARY_WALLPAPER" -m fill &
        ;;

    both)
        swaymsg "output \"$PRIMARY_DISPLAY\" enable mode ${RESOLUTION}@${REFRESH_RATE}Hz pos 0 0 scale $SCALE transform normal"
        swaymsg "output \"$SECONDARY_DISPLAY\" enable mode ${RESOLUTION}@${REFRESH_RATE}Hz scale $SCALE transform normal pos -${RESOLUTION%x*} 0"
        sleep 1
        swaybg -o "$SECONDARY_DISPLAY" -i "$SECONDARY_WALLPAPER" -m fill \
               -o "$PRIMARY_DISPLAY" -i "$PRIMARY_WALLPAPER" -m fill &
        ;;

    help|--help|-h|"")
        show_usage
        ;;

    *)
        echo "Error: Invalid mode '$1'"
        show_usage
        exit 1
        ;;
esac
