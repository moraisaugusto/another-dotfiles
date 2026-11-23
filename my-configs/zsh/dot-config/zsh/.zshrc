# zmodload zsh/zprof
# ==============================================================================
# 1. LOCALE & EDITOR
# ==============================================================================
# OS-specific settings (hardware, GTK/QT, Homebrew, ...) live in os/*.zsh.

# Locale & Language
export LANG=en_US.utf-8
export LC_ALL=en_US.utf-8

# Preferred editor (Fall back to vim on SSH, nvim locally)
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# ==============================================================================
# 2. PATH & ENVIRONMENT EXPORTS
# ==============================================================================

# Base System Paths
export PATH=$HOME/.bin:/usr/local/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"

# Node (Global NPM)
export PATH="$HOME/.npm-global/bin:$PATH"

# OS-specific settings
case $OSTYPE in
  darwin*) source "$ZDOTDIR/os/darwin.zsh" ;;
  linux*)  source "$ZDOTDIR/os/linux.zsh" ;;
esac

# ==============================================================================
# 3. EXTERNAL SOURCES & TOOLING
# ==============================================================================

# Version Manager (Mise)
eval "$(mise activate zsh)"

# Smart Jump (Zoxide)
eval "$(zoxide init zsh)"

# Direnv
eval "$(direnv hook zsh)"

# TMUX Configuration
export ZSH_TMUX_AUTOSTART=true
export ZSH_TMUX_AUTOCONNECT=true
export ZSH_TMUX_AUTOSTART_ONCE=true
export ZSH_TMUX_FIXTERM=true

# ==============================================================================
# TMUX AUTOSTART (Optimized)
# ==============================================================================
if [[ -o interactive && -z $TMUX && ( -n $DISPLAY || $OSTYPE == darwin* ) \
      && -z $INSIDE_EMACS && -z $VIM && -z $INTELLIJ_ENVIRONMENT_VARIABLES \
      && $TERM_PROGRAM != vscode ]] && (( $+commands[tmux] )); then
    # 1. Fix terminal if requested
    [[ "$ZSH_TMUX_FIXTERM" == "true" ]] && export TERM="screen-256color"

    # 2. Autoconnect or Start New
    if tmux has-session 2>/dev/null; then
        exec tmux attach-session
    else
        exec tmux new-session
    fi
fi

# ==============================================================================
# 4. CONFIGURATION FILES & SDKS
# ==============================================================================

# Source specific configuration files if they exist
[[ -f ~/.zshAlias ]] && source ~/.zshAlias
[[ -f ~/.secrets ]]  && source ~/.secrets
[[ -f ~/.pass ]]     && source ~/.pass
[[ -f ~/.pythonrc ]] && source ~/.pythonrc

# ==============================================================================
# 5. ZSH SHELL BEHAVIOR & PLUGINS
# ==============================================================================

# Prompt and Input behavior
unsetopt prompt_cr prompt_sp
unset zle_bracketed_paste

# Source all modular zsh configs from directory
for config ("$ZDOTDIR"/*.zsh) source $config
# zprof
#

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/home/augusto/.local/share/mise/installs/python/miniconda3-3.14-26.5.3-2/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/home/augusto/.local/share/mise/installs/python/miniconda3-3.14-26.5.3-2/etc/profile.d/conda.sh" ]; then
#         . "/home/augusto/.local/share/mise/installs/python/miniconda3-3.14-26.5.3-2/etc/profile.d/conda.sh"
#     else
#         export PATH="/home/augusto/.local/share/mise/installs/python/miniconda3-3.14-26.5.3-2/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<
