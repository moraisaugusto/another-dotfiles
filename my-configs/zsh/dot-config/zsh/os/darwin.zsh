# ~/.config/zsh/os/darwin.zsh -- macOS-only settings, sourced from .zshrc.
# Homebrew's shellenv runs from .zprofile.

# ==============================================================================
# PATH
# ==============================================================================

export PATH="$HOME/bin:/opt/homebrew/opt/libpq/bin:/opt/homebrew/opt/sqlite/bin:$HOME/.ana/bin:$PATH"

# Kilo
export PATH="$HOME/.kilo/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end

# ==============================================================================
# CONDA (lazy-load -- only initialise when you actually call conda)
# ==============================================================================

# Must match the `python` version in extras/config/mise/config.toml.
CONDA_ROOT="$HOME/.local/share/mise/installs/python/anaconda3-2026.07-1"
conda() {
  unfunction conda
  __conda_setup="$("$CONDA_ROOT/bin/conda" 'shell.zsh' 'hook' 2>/dev/null)"
  if [ $? -eq 0 ]; then
    eval "$__conda_setup"
  else
    [ -f "$CONDA_ROOT/etc/profile.d/conda.sh" ] \
      && source "$CONDA_ROOT/etc/profile.d/conda.sh" \
      || export PATH="$CONDA_ROOT/bin:$PATH"
  fi
  unset __conda_setup
  conda "$@"
}

# ==============================================================================
# ALIASES
# ==============================================================================

alias vi=nvim
alias restart-docker="osascript -e 'quit app \"Docker\"' && open -a Docker"
alias free-mac='vm_stat | perl -ne '"'"'/page size of (\d+)/ and $size=$1; /Pages\s+([^:]+)[^\d]+(\d+)/ and printf("%-16s % 16.2f Mi\n", "$1:", $2 * $size / 1048576);'"'"''

# ==============================================================================
# POMODORO
# ==============================================================================

POMODORO_BEFORE_LONG_BREAK=4
alias pause_sound="mpv $HOME/.dotfiles/extras/sounds/pause.mp3 > /dev/null 2>&1"
alias work="timer 25m -n 'Work' && pause_sound && notify-send -u low 'Pomodoro' 'Work Timer is up! Take a Break 😊'"
alias rest="timer 5m -n 'Rest' && pause_sound && notify-send -u low 'Pomodoro' 'Break is over! Get back to work 😬'"
alias long_rest="timer 15m -n 'Long Rest' && pause_sound && notify-send -u low 'Pomodoro' 'Long Break is over! Get back to work 😬'"
alias pomodoro='repeat $POMODORO_BEFORE_LONG_BREAK {work && rest} && long_rest'

start_work() { repeat $1 {work; rest} && rest }
