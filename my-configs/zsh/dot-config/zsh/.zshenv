# ~/.config/zsh/.zshenv
#
# Read by every zsh, including the non-interactive login shell that SDDM and
# LightDM run before starting the session. This is the shared hook that makes
# ~/.config/scaling.env apply to both X11 (i3) and Wayland (sway).
#
# NOTE: ZDOTDIR is set to ~/.config/zsh in /etc/zsh/zshenv, so this file is the
# active .zshenv -- ~/.zshenv in $HOME is not used.

[ -f "$HOME/.config/scaling.env" ] && . "$HOME/.config/scaling.env"
