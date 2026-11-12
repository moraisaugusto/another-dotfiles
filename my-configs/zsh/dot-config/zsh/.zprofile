# ~/.config/zsh/.zprofile
#
# Read by the login shell SDDM/LightDM run before starting the session.
#
# /etc/environment (pam_env) provides GTK_THEME=Arc:dark. The systemd --user
# manager keeps PAM-provided variables even after `unset-environment`, so
# D-Bus activated apps would still inherit Arc and break libadwaita styling.
# An empty value means "no override": each toolkit then reads its settings.ini
#   GTK3 -> ~/.config/gtk-3.0/settings.ini (Arc-Dark)
#   GTK4 -> ~/.config/gtk-4.0/settings.ini (Adwaita, prefer-dark)
# This becomes unnecessary once GTK_THEME is removed from /etc/environment.

unset GTK_THEME
systemctl --user set-environment GTK_THEME= 2>/dev/null

# Give D-Bus/systemd-activated apps (Nautilus, GNOME apps) the same scale as
# apps launched from i3/rofi/terminals.
if [ "${XDG_SESSION_TYPE:-x11}" = "x11" ] && [ -f "$HOME/.config/scaling.env" ]; then
    . "$HOME/.config/scaling.env"
    systemctl --user set-environment \
        GDK_SCALE="$GDK_SCALE" \
        GDK_DPI_SCALE="$GDK_DPI_SCALE" \
        XCURSOR_SIZE="$XCURSOR_SIZE" \
        QT_SCALE_FACTOR="$QT_SCALE_FACTOR" \
        QT_AUTO_SCREEN_SCALE_FACTOR="$QT_AUTO_SCREEN_SCALE_FACTOR" \
        QT_FONT_DPI="$QT_FONT_DPI" 2>/dev/null
fi
