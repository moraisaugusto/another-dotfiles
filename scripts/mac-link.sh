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

# Directory configs that apps keep open: ask before replacing a real directory.
pending_dirs=()
for app in kilo karabiner; do
  dest="$HOME/.config/$app"
  if [[ -e "$dest" && ! ( -L "$dest" && "$(readlink "$dest")" == "$DOTFILES/extras/config/$app" ) ]]; then
    pending_dirs+=("$app")
  fi
done
if (( ${#pending_dirs[@]} > 0 )) && [[ -t 0 ]]; then
  echo "About to replace ~/.config/{${pending_dirs[*]}} with symlinks."
  echo "Quit Kilo and Karabiner-Elements first. Press Enter to continue, Ctrl-C to abort."
  read -r _
fi

echo "Linking from $DOTFILES"

# Shell
link "$DOTFILES/symlinks/zshrc.symlink"      "$HOME/.zshrc"
link "$DOTFILES/symlinks/zshAlias.symlink"   "$HOME/.zshAlias"
link "$DOTFILES/symlinks/tmux-work.symlink"  "$HOME/.tmux.conf"
link "$DOTFILES/extras/oh-my-zsh/custom/themes/augusto-default.zsh-theme" \
     "$HOME/.oh-my-zsh/themes/augusto-default.zsh-theme"

# XDG configs
link "$DOTFILES/symlinks/direnvrc.symlink"         "$HOME/.config/direnv/direnvrc"
link "$DOTFILES/extras/config/ghostty/mac-config"  "$HOME/.config/ghostty/config"
link "$DOTFILES/extras/config/mise"                "$HOME/.config/mise"
link "$DOTFILES/extras/config/karabiner"           "$HOME/.config/karabiner"
link "$DOTFILES/extras/config/kilo"                "$HOME/.config/kilo"

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
