# zmodload zsh/zprof
# ==============================================================================
# 1. SYSTEM & HARDWARE (RTX 4090)
# ==============================================================================

# Hardware Acceleration (NVIDIA VA-API for Brave/Browsers)
export LIBVA_DRIVER_NAME=nvidia

# Locale & Language
export LANG=en_US.utf-8
export LC_ALL=en_US.utf-8

# Preferred editor (Fall back to vim on SSH, nvim locally)
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Themes & UI Interface Settings
export GTK_THEME=Arc:dark
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
# 2. PATH & ENVIRONMENT EXPORTS
# ==============================================================================

# R & Data Science
export IRACE_HOME=~/.R_libs/irace
export R_LIBS=~/.R_libs

# Base System Paths
export PATH=$HOME/.bin:/usr/local/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"
export MANPATH="/usr/local/man:$MANPATH"
export ARCHFLAGS="-arch x86_64"
export QUOTING_STYLE=literal # for ls behavior
export LD_LIBRARY_PATH

# Java (JDK 21)
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk/
export PATH=$PATH:$HOME/bin:$JAVA_HOME/bin:$HOME/.config/i3/i3lock-fancy-multimonitor

# Ruby (Gems)
export PATH=$PATH:$HOME/.local/share/gem/ruby/3.4.0/bin

# Node (Global NPM)
export PATH="$HOME/.npm-global/bin:$PATH"


# ==============================================================================
# 3. EXTERNAL SOURCES & TOOLING
# ==============================================================================

# Version Manager (Mise)
eval "$(mise activate zsh)"

# Smart Jump (Zoxide)
eval "$(zoxide init zsh)"

# TMUX Configuration
export ZSH_TMUX_AUTOSTART=true
export ZSH_TMUX_AUTOCONNECT=true
export ZSH_TMUX_AUTOSTART_ONCE=true
export ZSH_TMUX_FIXTERM=true

# ==============================================================================
# TMUX AUTOSTART (Optimized)
# ==============================================================================
if [[ -z "$TMUX" && -n "$DISPLAY" ]]; then
    # 1. Fix terminal if requested
    [[ "$ZSH_TMUX_FIXTERM" == "true" ]] && export TERM="screen-256color"

    # 2. Autoconnect or Start New
    if tmux has-session 2>/dev/null; then
        exec tmux attach-session
    else
        exec tmux new-session
    fi
fi

# SSH Agent Logic (Starts agent and adds keys if not running)
ps -u $(whoami) | grep ssh-agent &> /dev/null
if [ $? -ne 0 ]; then
    eval "$(ssh-agent -s)" >&/dev/null
    source $HOME/.dotfiles/bin/sshrc.sh
    ls ~/.ssh/id_rsa* | awk '!/pub$/ {system("ssh-add "$0 " 2>/dev/null")} '
fi
trap 'ssh-agent -k; exit' 0

# ==============================================================================
# 4. CONFIGURATION FILES & SDKS
# ==============================================================================

# Source specific configuration files if they exist
[[ -f ~/.zshAlias ]] && source ~/.zshAlias
[[ -f ~/.secrets ]]  && source ~/.secrets
[[ -f ~/.pass ]]     && source ~/.pass
[[ -f ~/.pythonrc ]] && source ~/.pythonrc

# Google Cloud SDK (Path and Completion)
if [ -f '/opt/google/google-cloud-sdk/path.zsh.inc' ]; then 
    . '/opt/google/google-cloud-sdk/path.zsh.inc'
fi
if [ -f '/opt/google/google-cloud-sdk/completion.zsh.inc' ]; then 
    . '/opt/google/google-cloud-sdk/completion.zsh.inc'
fi

# ==============================================================================
# 5. ZSH SHELL BEHAVIOR & PLUGINS
# ==============================================================================

# Prompt and Input behavior
unsetopt prompt_cr prompt_sp
unset zle_bracketed_paste

# Source all modular zsh configs from directory
for config (~/.config/zsh/*.zsh) source $config
# zprof
