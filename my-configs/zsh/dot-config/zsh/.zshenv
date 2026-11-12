# ~/.config/zsh/.zshenv
#
# Read by every zsh, including the non-interactive login shell that SDDM and
# LightDM run before starting the session. This is the shared hook that makes
# ~/.config/scaling.env apply to both X11 (i3) and Wayland (sway).
#
# NOTE: ZDOTDIR is set to ~/.config/zsh in /etc/zsh/zshenv, so this file is the
# active .zshenv -- ~/.zshenv in $HOME is not used.

[ -f "$HOME/.config/scaling.env" ] && . "$HOME/.config/scaling.env"

# Do not force a global GTK theme. /etc/environment still provides
# GTK_THEME=Arc:dark via pam_env; drop it for the session so each toolkit
# reads its own settings:
#   GTK3 -> ~/.config/gtk-3.0/settings.ini (Arc-Dark)
#   GTK4/libadwaita -> ~/.config/gtk-4.0/settings.ini (Adwaita, prefer-dark)
unset GTK_THEME
