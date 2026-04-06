#!/bin/bash

wid=$(xdotool search --classname urxvtq)

if [ -z "$wid" ]; then
  urxvt -name urxvtq -geometry 80x28 &
  sleep 0.1
  wid=$(xdotool search --classname urxvtq)
  xdotool windowactive $wid
  xdotool windowmove $wid 0 0
  xdotool windowfocus $wid
  #xdotool key Control_L+l
elif [ -z "$(xdotool search --onlyvisible --classname urxvtq 2>/dev/null)" ]; then
  xdotool windowmap $wid
  xdotool windowfocus $wid
  xdotool windowmove $wid 0 0
else
  xdotool windowunmap $wid
fi
