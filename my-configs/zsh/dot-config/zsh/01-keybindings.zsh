# Use Emacs mode to fix line navigation (prevents defaulting to Vi mode)
bindkey -e

# Bind Ctrl+P to Previous command
bindkey '^P' up-line-or-history

# Bind Ctrl+N to Next command
bindkey '^N' down-line-or-history

# Native History Substring Search Logic
# This binds Up/Down arrows to search history based on what is already typed
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Keybindings for standard Arrow Keys
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# Keybindings for Vi-mode (if you use it) or specific terminal emulators
bindkey -M emacs '^[[A' up-line-or-beginning-search
bindkey -M emacs '^[[B' down-line-or-beginning-search
