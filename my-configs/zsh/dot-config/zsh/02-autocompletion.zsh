#█▓▒░ 1. Autocompletion System Setup
ZCOMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-$ZSH_VERSION"

# Ensure directory exists
[[ -d "${ZCOMPDUMP:h}" ]] || mkdir -p "${ZCOMPDUMP:h}"

autoload -Uz compinit

if [[ -s "$ZCOMPDUMP" ]]; then
  # -C: Skip security check
  # -n: Do not rewrite the dump file
  compinit -C -n -d "$ZCOMPDUMP"
else
  compinit -d "$ZCOMPDUMP"
fi

# █▓▒░ THE LOCK: Disable further compinit/compdef calls
# This stops any other script from triggering the 719 calls
compinit() { return 0 }
compdef() { return 0 }

# Compile in background for speed
if [[ "$ZCOMPDUMP" -nt "$ZCOMPDUMP.zwc" ]]; then
  zcompile "$ZCOMPDUMP"
fi

autoload -Uz bashcompinit && bashcompinit
#█▓▒░ 2. Completion Behavior & Matching
# Define how completions are generated and matched
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

#█▓▒░ 3. Menu & Interface
# Configuration for the interactive TAB menu
zstyle ':completion:*:*:*:*:*' menu select=2
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-prompt %SAt %p: hit TAB for more, or the character to insert%s
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s

#█▓▒░ 4. Visuals & Colors
# Highlighting and directory colors
# ma=44;30;1 -> Blue background, Black text, Bold
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} "ma=44;30;1"
zstyle ':completion:*' list-colors 'di=01;38;5;208'

#█▓▒░ 5. Command Specifics
# Custom behavior for specific commands
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,cmd'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
