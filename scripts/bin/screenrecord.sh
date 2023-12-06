#!/bin/bash
#
# screen_record.sh - A simple script to record the screen using ffmpeg
# Author: Augusto Morais
#
# Usage:
#   screen_record.sh {--main-monitor|--second-monitor|--both-monitors} [--no-audio] <output_filename>
#
# Options:
#   --main-monitor    Record on the main monitor
#   --second-monitor  Record on the second monitor
#   --both-monitors   Record on both monitors
#   --no-audio        Exclude audio from the recording
#
# Example Usage:
#   ./screen_record.sh --main-monitor --no-audio output_main.mp4
#   ./screen_record.sh --second-monitor output_second.mp4
#   ./screen_record.sh --both-monitors --no-audio output_both.mp4

# Function to show a desktop notification
function show_notification {
    notify-send "Screen Recording" "$1"
}

# Check the number of command-line arguments
if [ "$#" -lt 2 ] || [ "$#" -gt 3 ]; then
    echo "Usage: $0 {--main-monitor|--second-monitor|--both-monitors} [--no-audio] <output_filename>"
    exit 1
fi

# Extract command-line arguments
if [ "$#" -eq 3 ] && [ "$2" == "--no-audio" ]; then
    output_filename=$3
    audio_options=""
# Check for the --no-audio option
else
    output_filename=$2
    audio_options="-f pulse -ac 2 -i default"
fi

# Select the appropriate screen recording command based on the chosen option
case "$1" in
    --main-monitor)
        show_notification "Starting record on the main monitor - DP-0"
        ffmpeg -video_size $(xrandr | awk '/\*/ {print $1}' | head -n 1) -framerate 25 -f x11grab -i :0.0+$(xrandr | awk '/\*/ {print $1}' | tail -n 1 | cut -d'x' -f1) $audio_options  "$output_filename"
        ;;
    --second-monitor)
        show_notification "Starting record on the second monitor - DP-2"
        ffmpeg -video_size $(xrandr | awk '/\*/ {print $1}' | head -n 1) -framerate 25 -f x11grab -i :0.0 $audio_options "$output_filename"
        ;;
    --both-monitors)
        show_notification "Starting record on both monitors - DP-0 and DP-2"
        ffmpeg -video_size $(xdpyinfo | grep dimensions | awk '{print $2}') -framerate 25 -f x11grab -i :0.0 $audio_options "$output_filename"
        ;;
    *)
        echo "Invalid option: $1"
        echo "Usage: $0 {--main-monitor|--second-monitor|--both-monitors}"
        exit 1
        ;;
esac
