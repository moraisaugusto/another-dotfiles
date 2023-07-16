#!/bin/bash
PRIMARY_OUTPUT="DP-0"
SECONDARY_OUTPUT="DP-2"

# if we don't have a file, start at zero
if [ ! -f "/tmp/monitor_mode.dat" ] ; then
  monitor_mode="all"

# otherwise read the value from the file
else
  monitor_mode=`cat /tmp/monitor_mode.dat`
fi

if [ $monitor_mode = "all" ]; then
        monitor_mode="EXTERNAL"
        xrandr --output $PRIMARY_OUTPUT --off --output $SECONDARY_OUTPUT --auto
elif [ $monitor_mode = "EXTERNAL" ]; then
        monitor_mode="INTERNAL"
        xrandr --output $PRIMARY_OUTPUT --auto --output $SECONDARY_OUTPUT --off
elif [ $monitor_mode = "INTERNAL" ]; then
        monitor_mode="CLONES"
        xrandr --output $PRIMARY_OUTPUT --auto --output $SECONDARY_OUTPUT --auto --same-as $PRIMARY_OUTPUT
else
        monitor_mode="all"
        xrandr --output $PRIMARY_OUTPUT --primary --mode 3840x2160 --pos 0x0 --rotate normal --output $SECONDARY_OUTPUT --auto --left-of $PRIMARY_OUTPUT --mode 3840x2160
fi
echo "${monitor_mode}" > /tmp/monitor_mode.dat
