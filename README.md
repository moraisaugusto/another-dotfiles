# ⚡ Another Dotfiles

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/platform-linux-lightgrey)](https://www.kernel.org/)
[![Shell](https://img.shields.io/badge/shell-zsh-89e051)](https://www.zsh.org/)
[![Editor](https://img.shields.io/badge/editor-vim-019733)](https://www.vim.org/)
[![Window Manager](https://img.shields.io/badge/i3wm-modified-blue)](https://i3wm.org/)
[![Terminal](https://img.shields.io/badge/tmux-256color-4477aa)](https://tmux.github.io/)
[![Status Bar](https://img.shields.io/badge/polybar-modular-ff6653)](https://polybar.github.io/)
[![Launcher](https://img.shields.io/badge/rofi-configurable-e436f0)](https://davedavenport.github.io/rofi/)

A curated collection of dotfiles optimized for a lightweight **Arch + i3wm** workflow. Keyboard-driven productivity configurations for i3 window manager, tmux terminal multiplexer, polybar status bar, rofi launcher, and more.

## Features

### Core Components
- **i3 Tiling Window Manager** - Keyboard-driven layout with custom workspaces, animations, multimedia keys, and auto-start applications
- **tmux Terminal Multiplexer** - 256-color terminal, Vi keybindings, mouse support, copy-paste integration, and pane synchronization
- **polybar Status Bar** - Real-time system metrics (CPU, memory, battery, network, temperature), custom audio/network modules, and weather support
- **rofi Application Launcher** - DRun, Run, SSH, and Window modes with themed squared-nord design
- **ZSH/Vim/Dunst/Picom** - Complete shell, editor, and UI configuration suite

## Installation

### Method 1: Using stow (Recommended)

```bash
cd ~/
git clone https://github.com/moraisaugusto/another-dotfiles.git dotfiles
cd dotfiles
git submodule update --init --recursive
stow .
source zsh
```

### Method 2: Manual

```bash
cd ~ && git clone https://github.com/moraisaugusto/another-dotfiles.git dotfiles
cd dotfiles
git submodule update --init --recursive
# Create symlinks to appropriate files
```

### Method 3: Install Script

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/moraisaugusto/another-dotfiles/master/install.sh)"
```

> ⚠️ **Note:** Install scripts replace existing configs - backup before running.

## Requirements

### System
- Arch Linux or systemd-based distribution
- i3 (4+), ZSH (5+), polybar, rofi
- Terminal emulator (URXVT, Termite, Ghostty)
- Clipboard tools (xsel/xclip)

### Essential Packages (Arch)

```bash
sudo pacman -S i3 i3-gaps polybar rofi zsh vim dunst picom \
  scrot feh xsel git tmux xautolock i3lock archlinux-wallpaper \
  networkmanager pulseaudio pamixer brightnessctl
```

**Recommended:**
```bash
sudo pacman -S alacritty urxvt pulseaudio-pulse playerctl mpv audacious \
  fff exa bat delta ripgrep fd-find tealdeer jq wget curl aria2
```

## Quick Start Keybindings

### i3 Window Manager (Mod4/Super)
- `Mod4+d` - Open rofi launcher
- `Mod4+hjkl` - Move focus cursor
- `Ctrl+a | -` - Split pane vertically/horizontally
- `Mod4+1-0` - Switch workspace
- `Mod4+Shift+q` - Kill window
- `Mod4+f` - Toggle fullscreen
- `Mod4+r` - Enter resize mode

### tmux Terminal (Ctrl+a)
- `Ctrl+a+c` - New window
- `Ctrl+a+d` - Detach session
- `Ctrl+a+hjkl` - Navigate panes

### Polybar Status Bar
- **Middle click** audio module - Mute toggle
- **Scroll** audio module - Volume adjust
- **Left click** monitor module - Open arandr

### Rofi Launcher
- `Super+d` - Applications
- `Ctrl+Alt` - Switch modes


## Complete Documentation

### tmux Advanced Use
**Navigate to previous/next window:**
```bash
Ctrl+a, or Ctrl+a+.
```

**Switch pane orientation:**
```bash
Ctrl+a+; or Ctrl+a+'
```

**Copy text:**
```bash
Ctrl+a+[ Enter, then select text, Enter to copy
Ctrl+a+ = Paste from clipboard
```


## Directory Structure

```
~/.dotfiles/
├── i3/.config/i3/config          # i3 window manager
├── tmux/.config/tmux/            # tmux configurations
├── polybar/.config/polybar/      # Status bar
├── rofi/.config/rofi/config.rasi # Launcher
├── zsh/.zshrc                    # Shell configuration
├── vim/.vimrc                    # Editor configuration
├── extras/                       # Additional modules and themes
│   ├── zsh/custom/ themes/        # ZSH themes
│   ├── zsh/custom/plugins/       # ZSH plugins
│   ├── polybar-scripts/          # Custom polybar modules
│   └── i3/                       # i3 extras
└── install.sh                    # Automated installer
```

## Maintenance

### Updating Dotfiles
```bash
cd ~/.dotfiles
git pull
git submodule update --remote
```

### Removing Dotfiles
```bash
cd ~/.dotfiles
stow -D .  # Remove all
# or
stow -D i3 tmux polybar rofi  # Remove specific
```

### Backup Configuration
```bash
cp -r ~/.config/i3 ~/.config/backups/i3
cp -r ~/.config/polybar ~/.config/backups/polybar
```

## Troubleshooting

### i3 Issues
- **Blank screen:** `i3 --dry-run` to check config
- **Background missing:** Check wallpaper paths and permissions
- **Apps failing to launch:** Validate window classes with `i3-msg -t get_tree`

---

## License

MIT License - see LICENSE file for details.

---

## Resources

- [i3wm Documentation](https://i3wm.org/docs/)
- [tmux Manual](https://man.archlinux.org/man/tmux.1.en)
- [polybar Wiki](https://github.com/polybar/polybar/wiki)
- [rofi Repository](https://github.com/davedavenport/rofi)
