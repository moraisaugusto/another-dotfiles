#!/bin/bash

# --- DISPLAY IDENTIFIERS ---
PRIMARY_DISPLAY="DP-4"
SECONDARY_DISPLAY="DP-2"

# --- DISPLAY SETTINGS ---
RESOLUTION="3840x2160"
REFRESH_RATE="120"
SCREEN_DPI="192"

# --- WALLPAPER SETTINGS ---
WALLPAPER_DIR="$HOME/GoogleDrive/wallpapers"
PRIMARY_WALLPAPER="$WALLPAPER_DIR/space-exploration.jpg"
SECONDARY_WALLPAPER="$WALLPAPER_DIR/mount.png"

# --- HELPER FUNCTIONS ---
show_usage() {
    cat << EOF
Usage: $(basename "$0") [MODE]

A display and wallpaper manager for i3wm/Polybar.

Available Modes:
  primary      Enable only $PRIMARY_DISPLAY (Main)
  secondary    Enable only $SECONDARY_DISPLAY (Side)
  both         Enable both monitors ($SECONDARY_DISPLAY to the left of $PRIMARY_DISPLAY)
  help         Display this help message

If only one display is attached, "both" falls back to the one that is.

Settings:
  Resolution:  $RESOLUTION
  Refresh:     $REFRESH_RATE Hz
  DPI:         $SCREEN_DPI
EOF
}

# True when the output has a display attached. Every connector name exists in
# xrandr even with nothing plugged in (DP-5 is a phantom on this GPU), so check
# the status instead of the name.
is_connected() {
    xrandr 2>/dev/null | grep -q "^$1 connected"
}

# Basic Check: Ensure wallpaper directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
    notify-send "Display Manager" "Warning: Wallpaper directory not found at $WALLPAPER_DIR"
fi

case "$1" in
    primary)
        is_connected "$PRIMARY_DISPLAY" || {
            notify-send "Display Manager" "$PRIMARY_DISPLAY is not connected"
            exit 1
        }
        xrandr --output "$PRIMARY_DISPLAY" --primary --mode "$RESOLUTION" \
               --rate "$REFRESH_RATE" --dpi "$SCREEN_DPI" --pos 0x0 --rotate normal \
               --output "$SECONDARY_DISPLAY" --off
        sleep 1
        feh --bg-fill "$PRIMARY_WALLPAPER"
        ;;

    secondary)
        is_connected "$SECONDARY_DISPLAY" || exec "$0" primary
        xrandr --output "$SECONDARY_DISPLAY" --primary --mode "$RESOLUTION" \
               --rate "$REFRESH_RATE" --dpi "$SCREEN_DPI" --pos 0x0 --rotate normal \
               --output "$PRIMARY_DISPLAY" --off
        sleep 1
        feh --bg-fill "$SECONDARY_WALLPAPER"
        ;;

    both)
        # Degrade gracefully when only one display is attached (secondary
        # powered off or moved to another machine).
        is_connected "$PRIMARY_DISPLAY"   || exec "$0" secondary
        is_connected "$SECONDARY_DISPLAY" || exec "$0" primary
        xrandr --output "$PRIMARY_DISPLAY" --primary --mode "$RESOLUTION" \
               --rate "$REFRESH_RATE" --dpi "$SCREEN_DPI" --pos 0x0 --rotate normal \
               --output "$SECONDARY_DISPLAY" --mode "$RESOLUTION" --rate "$REFRESH_RATE" \
               --dpi "$SCREEN_DPI" --left-of "$PRIMARY_DISPLAY"
        sleep 1
        feh --bg-fill "$SECONDARY_WALLPAPER" --output "$SECONDARY_DISPLAY" \
            --bg-fill "$PRIMARY_WALLPAPER" --output "$PRIMARY_DISPLAY"
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
