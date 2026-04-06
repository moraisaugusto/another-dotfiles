#!/bin/bash
#

# Function to show a desktop notification
function show_notification {
    notify-send "Screen Recording" "$1"
}

# Extract coordinates and size
selected_area=$(slop -f "%x %y %w %h %g %i") || exit 1
read -r X Y W H G ID <<< $selected_area

# Record the selected window using ffmpeg
ffmpeg -s "$W"x"$H" -framerate 25 -f x11grab -i :0.0+$X,$Y -f pulse -ac 2 -i default output.mp4
