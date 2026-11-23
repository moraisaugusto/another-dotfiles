#!/usr/bin/env bash
# Idempotently link macOS configs from ~/.dotfiles into $HOME.
# Existing (non-matching) targets are moved to "<target>-old.<timestamp>".
# Usage: ~/.dotfiles/scripts/mac-link.sh
set -euo pipefail

if [[ "$(uname)" != "Darwin" ]]; then
  echo "mac-link.sh: macOS only (uname=$(uname)); use install.sh on Linux." >&2
  exit 1
fi

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TS="$(date +%Y%m%d-%H%M%S)"
CHANGED=0

# link SRC DEST
link() {
  local src="$1" dest="$2"

  if [[ ! -e "$src" ]]; then
    echo "  !! missing source: $src (skipping)" >&2
    return
  fi

  if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
    echo "  ok   $dest"
    return
  fi

  mkdir -p "$(dirname "$dest")"

  if [[ -e "$dest" || -L "$dest" ]]; then
    mv "$dest" "$dest-old.$TS"
    echo "  bak  $dest -> $dest-old.$TS"
  fi

  ln -s "$src" "$dest"
  echo "  link $dest -> $src"
  CHANGED=1
}

# retire PATH: move a file zsh no longer reads out of the way (idempotent).
retire() {
  local target="$1"
  if [[ -e "$target" || -L "$target" ]]; then
    mv "$target" "$target-old.$TS"
    echo "  bak  $target -> $target-old.$TS (no longer read; ZDOTDIR=~/.config/zsh)"
    CHANGED=1
  fi
}

# Directory configs that apps keep open: ask before replacing a real directory.
pending_dirs=()
for entry in \
  "kilo:$DOTFILES/extras/config/kilo" \
  "karabiner:$DOTFILES/extras/config/karabiner" \
  "zsh:$DOTFILES/my-configs/zsh/dot-config/zsh"; do
  app="${entry%%:*}"
  src="${entry#*:}"
  dest="$HOME/.config/$app"
  if [[ -e "$dest" && ! ( -L "$dest" && "$(readlink "$dest")" == "$src" ) ]]; then
    pending_dirs+=("$app")
  fi
done
if (( ${#pending_dirs[@]} > 0 )) && [[ -t 0 ]]; then
  echo "About to replace ~/.config/{${pending_dirs[*]}} with symlinks."
  echo "Quit Kilo and Karabiner-Elements and close other shells first."
  echo "Press Enter to continue, Ctrl-C to abort."
  read -r _
fi

echo "Linking from $DOTFILES"

# Shell (zsh config lives in ~/.config/zsh; ~/.zshenv sets ZDOTDIR)
link "$DOTFILES/my-configs/zsh/dot-zshenv"         "$HOME/.zshenv"
link "$DOTFILES/my-configs/zsh/dot-config/zsh"     "$HOME/.config/zsh"
link "$DOTFILES/symlinks/zshAlias.symlink"         "$HOME/.zshAlias"
link "$DOTFILES/symlinks/tmux-work.symlink"        "$HOME/.tmux.conf"
retire "$HOME/.zshrc"
retire "$HOME/.zprofile"

# zsh state/cache dirs and history migration (never overwrites)
mkdir -p "$HOME/.local/state/zsh" "$HOME/.cache/zsh"
if [[ ! -e "$HOME/.local/state/zsh/history" && -f "$HOME/.zsh_history" ]]; then
  cp -p "$HOME/.zsh_history" "$HOME/.local/state/zsh/history"
  echo "  copy ~/.zsh_history -> ~/.local/state/zsh/history"
  CHANGED=1
fi

# Starship prompt
link "$DOTFILES/my-configs/starship/dot-config/starship"   "$HOME/.config/starship"
link "$DOTFILES/my-configs/config/dot-config/starship.toml" "$HOME/.config/starship.toml"

# XDG configs
link "$DOTFILES/symlinks/direnvrc.symlink"         "$HOME/.config/direnv/direnvrc"
link "$DOTFILES/extras/config/ghostty/mac-config"  "$HOME/.config/ghostty/config"
link "$DOTFILES/extras/config/mise"                "$HOME/.config/mise"
link "$DOTFILES/extras/config/karabiner"           "$HOME/.config/karabiner"
link "$DOTFILES/extras/config/kilo"                "$HOME/.config/kilo"

# Tools the zsh config expects (warn only)
missing=()
for tool in starship eza tmuxinator; do
  command -v "$tool" >/dev/null 2>&1 || missing+=("$tool")
done
if (( ${#missing[@]} > 0 )); then
  echo
  echo "Missing tools: ${missing[*]}"
  echo "  brew install ${missing[*]}"
fi

# Secrets
if [[ -f "$HOME/.secrets" ]]; then
  chmod 600 "$HOME/.secrets"
else
  echo
  echo "Reminder: create ~/.secrets (chmod 600) with machine-local exports, e.g."
  echo "  ANACONDA_ORG_DOWNLOAD_TOKEN, PIP_EXTRA_INDEX_URL, AWS_PROFILE, AWS_REGION, ANTHROPIC_MODEL"
fi

echo
if (( CHANGED )); then
  echo "Done. Open a new terminal (and restart Kilo / Karabiner-Elements) to pick up changes."
else
  echo "Nothing to do; everything already linked."
fi
