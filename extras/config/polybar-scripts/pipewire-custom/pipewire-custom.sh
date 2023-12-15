#!/bin/sh
declare -A outputs

# Add key-value pairs to the dictionary
outputs["Audioengine_HD4"]="蓼"
outputs["World_Computing_OWC"]=""

getDefaultSink() {
    defaultSink=$(pactl info | awk -F : '/Default Sink:/{print $2}')
    description=$(pactl list sinks | grep -v "hdmi" | sed -n "/${defaultSink}/,/Description/s/^\s*Description: \(.*\)/\1/p")

    for key in "${!outputs[@]}"; do
      #echo ${defaultSink}
      
      if [[ "$defaultSink" == *"$key"* ]]; then
        echo "${outputs[$key]}"
      fi
    done
    #echo "${description}"
}

setDefaultSink() {
  default_sink=$(pactl info | grep "Default Sink:" | cut '-d ' -f3)
  sinks=$(pactl list short sinks |grep -v "hdmi" | cut -f2)

  # for wrap-around
  sinks="$sinks
  $sinks"
  
  next_sink=$(echo "$sinks" | awk "/$default_sink/{getline x;print x;exit;}")
  
  pactl set-default-sink $next_sink
  echo "sink: $next_sink"
  pactl list short sink-inputs | \
  cut -f1 | \
  xargs -I{} pactl move-sink-input {} $next_sink

}

VOLUME=$(pamixer --get-volume-human)
SINK=$(getDefaultSink)

case $1 in
    "--up")
        pamixer --increase 2
        ;;
    "--down")
        pamixer --decrease 2
        ;;
    "--mute")
        pamixer --toggle-mute
        ;;
    "--change-sink")
        setDefaultSink
        ;;
    *)
        echo " ${SINK} ${VOLUME}"
esac
