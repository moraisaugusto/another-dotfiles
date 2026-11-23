#!/bin/sh
# Re-train the NVIDIA DisplayPort link after resuming from suspend (S3).
#
# After a power transition the DP-4 (ROG XG27UQ) link can come back in a bad
# state: the panel blinks and only a fresh link train clears it. Running DPMS
# off/on forces that train. It happens while the screen is still black during
# resume, so it is invisible.
#
# Install (run once):
#   sudo cp extras/etc/systemd/system-sleep/nvidia-retrain.sh \
#           /usr/lib/systemd/system-sleep/
#   sudo chmod +x /usr/lib/systemd/system-sleep/nvidia-retrain.sh
#
# Called by systemd-sleep with "$1" = pre|post and "$2" = suspend|hibernate|...

USERNAME="augusto"

[ "$1" = "post" ] || exit 0

# No X server (suspended from a TTY, or before login): nothing to re-train.
pgrep -x Xorg >/dev/null 2>&1 || exit 0

# Resolve DISPLAY/XAUTHORITY from the user's systemd manager: SDDM points
# XAUTHORITY at a per-session file (e.g. /tmp/xauth_XXXXXX), not ~/.Xauthority.
UID_N=$(id -u "$USERNAME" 2>/dev/null) || exit 0
ENV_DUMP=$(su - "$USERNAME" -c "XDG_RUNTIME_DIR=/run/user/$UID_N systemctl --user show-environment" 2>/dev/null)

DISPLAY_N=$(printf '%s\n' "$ENV_DUMP" | sed -n 's/^DISPLAY=//p' | head -1)
XAUTH=$(printf '%s\n' "$ENV_DUMP" | sed -n 's/^XAUTHORITY=//p' | head -1)
[ -n "$DISPLAY_N" ] || DISPLAY_N=":0"
[ -n "$XAUTH" ] || XAUTH="/home/$USERNAME/.Xauthority"

export DISPLAY="$DISPLAY_N" XAUTHORITY="$XAUTH"

# Give the driver + server a moment to finish the resume modeset.
sleep 2

# Log the outcome so `journalctl -t nvidia-retrain` can explain a silent hook.
if xset dpms force off >/dev/null 2>&1; then
    logger -t nvidia-retrain "DPMS off OK (DISPLAY=$DISPLAY_N XAUTHORITY=$XAUTH)"
else
    logger -t nvidia-retrain "DPMS off FAILED (DISPLAY=$DISPLAY_N XAUTHORITY=$XAUTH)"
fi
sleep 1
xset dpms force on >/dev/null 2>&1

# Resume re-arms DPMS with the server defaults, so re-apply the idle policy
# here as well (the xorg.conf ServerFlags values keep it at zero afterwards).
xset s off >/dev/null 2>&1
xset dpms 0 0 0 >/dev/null 2>&1

exit 0
