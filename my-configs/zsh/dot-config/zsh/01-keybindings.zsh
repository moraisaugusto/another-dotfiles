# Remove ESC key delay for snappier menu exiting and mode switching
export KEYTIMEOUT=1

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

# Allow Ctrl+Left and Ctrl+Right to jump words
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word


#█▓▒░ 6. Keybindings
# Standard Shift+Tab (Backtab)
bindkey '^[[Z' reverse-menu-complete

# Shift+Tab specifically while the selection menu is open
zmodload zsh/complist
bindkey -M menuselect '^[[Z' reverse-menu-complete
# Press Escape to exit the completion menu
bindkey -M menuselect '^[' send-break

# 1. Use 'terminfo' to find the correct sequence for your terminal
# This covers most modern terminals (iTerm2, Alacritty, Kitty, Kitty, etc.)
bindkey "${terminfo[kdch1]}" delete-char

# 2. Fallback for terminals where terminfo might be missing
# This explicitly binds the common sequence for the Delete key
bindkey "^[[3~" delete-char
