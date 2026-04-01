#!/usr/bin/env sh

CAPACITY=$(cat /sys/class/power_supply/BAT1/capacity)

STATUS=$(cat /sys/class/power_supply/BAT1/status)

[ "$STATUS" = "Discharging" ] && [ "$CAPACITY" -lt 21 ] && \

/usr/bin/notify-send -u critical -a power_supply_low "Low Battery" "You are running low on battery ($CAPACITY%).\nPlease plug in the charger." && \

echo "Low Battery notification sent" && $(paplay .config/dunst/sounds/time-is-now-585.ogg) || \

echo "Low Battery notification not sent"


[ "$STATUS" = "Charging" ] && [ "$CAPACITY" -gt 99 ] && \

/usr/bin/notify-send -u normal -a power_supply_full "Battery Full" "Charge full ($CAPACITY%).\nPlease unplug from charger." && \

echo "Full Battery notification sent" && $(paplay .config/dunst/sounds/clearly-602.ogg) || \

echo "Full Battery notification not sent"
