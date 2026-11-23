# ~/.config/zsh/os/linux.zsh -- Linux-only settings, sourced from .zshrc.

# ==============================================================================
# SYSTEM & HARDWARE (RTX 4090)
# ==============================================================================

# Hardware Acceleration (NVIDIA VA-API for Brave/Browsers)
export LIBVA_DRIVER_NAME=nvidia

# Themes & UI Interface Settings
# No GTK_THEME here: GTK3 reads gtk-3.0/settings.ini (Arc-Dark),
# GTK4/libadwaita reads gtk-4.0/settings.ini (Adwaita, prefer-dark).
unset GTK_THEME
export QT_QPA_PLATFORMTHEME=qt5ct
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export NO_AT_BRIDGE=1 # fix for zathura

# Keyboard & Display
setxkbmap -layout us -variant intl

if [[ -n "$DISPLAY" ]]; then
    export BROWSER=brave
else 
    export BROWSER=links
fi

# ==============================================================================
# PATH & ENVIRONMENT EXPORTS
# ==============================================================================

# R & Data Science
export IRACE_HOME=~/.R_libs/irace
export R_LIBS=~/.R_libs

export MANPATH="/usr/local/man:$MANPATH"
export ARCHFLAGS="-arch x86_64"
export QUOTING_STYLE=literal # for ls behavior
export LD_LIBRARY_PATH

# Java (JDK 21)
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk/
export PATH=$PATH:$HOME/bin:$JAVA_HOME/bin:$HOME/.config/i3/i3lock-fancy-multimonitor

# Ruby (Gems)
export PATH=$PATH:$HOME/.local/share/gem/ruby/3.4.0/bin

# ==============================================================================
# SSH AGENT
# ==============================================================================

# SSH Agent Logic (Starts agent and adds keys if not running)
ps -u $(whoami) | grep ssh-agent &> /dev/null
if [ $? -ne 0 ]; then
    eval "$(ssh-agent -s)" >&/dev/null
    source $HOME/.dotfiles/bin/sshrc.sh
    ls ~/.ssh/id_rsa* | awk '!/pub$/ {system("ssh-add "$0 " 2>/dev/null")} '
fi
trap 'ssh-agent -k; exit' 0

# ==============================================================================
# SDKS
# ==============================================================================

# Google Cloud SDK (Path and Completion)
if [ -f '/opt/google/google-cloud-sdk/path.zsh.inc' ]; then 
    . '/opt/google/google-cloud-sdk/path.zsh.inc'
fi
if [ -f '/opt/google/google-cloud-sdk/completion.zsh.inc' ]; then 
    . '/opt/google/google-cloud-sdk/completion.zsh.inc'
fi
