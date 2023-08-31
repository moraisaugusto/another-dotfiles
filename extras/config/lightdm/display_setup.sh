#!/bin/sh
xrandr --setprovideroutputsource modesetting NVIDIA-0
#xrandr --auto
xrandr --output HDMI-0 --off --output DP-0 --mode 3840x2160 --pos 0x0 --dpi 192 --rate 120.00 --rotate normal
