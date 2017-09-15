#!/bin/bash
pac=$(checkupdates | wc -l)
aur=$(cower -u | wc -l)

check=$((pac + aur))
if [[ "$check" != "0" ]]
then
    echo "$pac %{F#7a7a7a}%{F-} $aur"
else
    echo "%{F#BB6461}%{F-}"
fi
