# Dotfiles

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/platform-linux-lightgrey)](https://www.kernel.org/)
[![Shell](https://img.shields.io/badge/shell-zsh-89e051)](https://www.zsh.org/)
[![Editor](https://img.shields.io/badge/editor-neovim-019733)](https://neovim.io/)
[![Window Manager](https://img.shields.io/badge/i3wm-gaps-blue)](https://i3wm.org/)
[![Terminal](https://img.shields.io/badge/tmux-256color-4477aa)](https://tmux.github.io/)
[![Status Bar](https://img.shields.io/badge/polybar-modular-ff6653)](https://polybar.github.io/)
[![Launcher](https://img.shields.io/badge/rofi-drun-e436f0)](https://github.com/davatorium/rofi/)

A curated collection of dotfiles for a lightweight **Arch Linux + i3-gaps** workflow. Keyboard-driven productivity configurations for i3 window manager, tmux terminal multiplexer, polybar status bar, rofi launcher, and more.

## Features

### Core Components
- **i3-gaps Tiling Window Manager** - Keyboard-driven layout with custom workspaces, gaps, multimedia keys, and auto-start applications
- **tmux Terminal Multiplexer** - 256-color terminal, Vi keybindings, mouse support, copy-paste integration, and pane synchronization
- **polybar Status Bar** - Real-time system metrics (CPU, memory, battery, network, temperature), custom audio/network modules, weather and VPN support
- **rofi Application Launcher** - DRun, Run, SSH, and Window modes with themed squared-nord design
- **ZSH/Neovim/Dunst/Picom** - Complete shell, editor, and UI configuration suite

### Supported Applications
- **Terminals**: Ghostty, URXVT
- **Browsers**: Brave, Chromium, Firefox
- **Media**: Spotify, Tidal, mpv
- **File Managers**: Thunar, Nautilus

## Installation

Choose your preferred installation method:

### Quick Install

To install all configurations and shell basics in one go, run:

```bash
curl -sSL https://raw.githubusercontent.com/moraisaugusto/another-dotfiles/main/install.sh | bash -s -- install-all
```

### Option 1: Using Make (Recommended)

```bash
cd ~/.dotfiles
make all
```

Install specific components:
```bash
make shell      # ZSH and shell basics
make configs    # All applications
make i3         # i3 window manager
make tmux       # tmux terminal
make polybar    # polybar status bar
make rofi       # rofi launcher
```

Remove all configurations:
```bash
make delete
```

### Option 2: Using Stow (Recommended for advanced users)

```bash
cd ~/.dotfiles
git submodule update --init --recursive
stow --dotfiles -v shell-basics
```

Apply individual configurations:
```bash
stow --dotfiles -vv -d my-configs -t ~ i3
```

## Requirements

### System
- Linux distribution (Arch-based recommended)
- i3-gaps (4.x+), ZSH (5+), polybar, rofi
- Terminal emulator (URXVT, Ghostty, etc.)

### Essential Packages (Arch)

```bash
sudo pacman -S i3-gaps polybar rofi zsh neovim dunst picom \
  scrot feh xsel git tmux xautolock networkmanager \
  pulseaudio pamixer brightnessctl xdotool
```

## Quick Start Keybindings

### i3 Window Manager (Mod4/Super)

#### Focus & Movement
| Shortcut | Action |
|----------|--------|
| `Mod4+hjkl` | Move focus left/down/up/right |
| `Mod4+←↓↑→` | Move focus with arrow keys |
| `Mod4+Shift+hjkl` | Move focused window |
| `Mod4+Shift+←↓↑→` | Move window with arrow keys |
| `Mod4+space` | Toggle between tiling/floating |
| `Mod4+Shift+space` | Toggle floating mode |

#### Workspaces
| Shortcut | Action |
|----------|--------|
| `Mod4+1-0` | Switch to workspace 1-10 |
| `Mod4+Shift+1-0` | Move window to workspace |
| `Mod4+m` | Move workspace to left monitor |

#### Windows & Layout
| Shortcut | Action |
|----------|--------|
| `Mod4+f` | Toggle fullscreen |
| `Mod4+s` | Stacking layout |
| `Mod4+w` | Tabbed layout |
| `Mod4+e` | Toggle split layout |
| `Mod4+-|` | Split horizontal/vertical |
| `Mod4+r` | Enter resize mode |

#### Actions
| Shortcut | Action |
|----------|--------|
| `Mod4+d` | Open rofi launcher |
| `Mod4+Return` | Open terminal |
| `Mod4+Shift+q` | Kill focused window |
| `Mod4+Shift+c` | Reload config |
| `Mod4+Shift+r` | Restart i3 |
| `Mod4+Shift+p` | Open arandr (display settings) |
| `Mod4+Shift+s` | Open pavucontrol (sound) |
| `Mod4+Control+l` | Lock screen |
| `Mod4+F12` | Open URXVT terminal |

#### Multimedia Keys
| Shortcut | Action |
|----------|--------|
| `XF86AudioRaiseVolume` | Increase volume |
| `XF86AudioLowerVolume` | Decrease volume |
| `XF86AudioMute` | Toggle mute |
| `XF86AudioPlay/Pause` | Play/Pause media |
| `XF86AudioNext/Prev` | Next/Previous track |

### tmux Terminal (Ctrl+a)

#### Sessions & Windows
| Shortcut | Action |
|----------|--------|
| `Ctrl+a+c` | New window |
| `Ctrl+a+N` | New window (with path) |
| `Ctrl+a+d` | Detach session |
| `Ctrl+a+r` | Reload config |

#### Pane Navigation
| Shortcut | Action |
|----------|--------|
| `Ctrl+a+hjkl` | Navigate panes |
| `Ctrl+a+HJKL` | Resize panes |
| `Ctrl+a+C-h/l` | Previous/Next window |

#### Split Panes
| Shortcut | Action |
|----------|--------|
| `Ctrl+a+|` | Split horizontally |
| `Ctrl+a+-` | Split vertically |

#### Copy Mode (Vi)
| Shortcut | Action |
|----------|--------|
| `Ctrl+a+[` | Enter copy mode |
| `v` | Begin selection |
| `y` | Copy selection |
| `q` | Exit copy mode |

#### Other
| Shortcut | Action |
|----------|--------|
| `Ctrl+a+=` | Tile all windows |
| `Ctrl+a+y` | Synchronize panes |

### Polybar Status Bar

| Action | Module |
|--------|--------|
| **Middle click** audio module | Mute toggle |
| **Scroll** audio module | Volume adjust |
| **Left click** monitor module | Open arandr |
| **Left click** powermenu | Power options |
| **Left/Right click** Tailscale | Toggle VPN |

### Rofi Launcher

| Shortcut | Action |
|----------|--------|
| `Mod4+d` | Open applications (DRun) |
| `Ctrl+Alt` | Switch modes |

## Workspace Assignments

| Workspace | Icon | Application |
|-----------|------|-------------|
| 1 | Browser | Brave, Chromium, Firefox |
| 2 | Terminal | URXVT, Ghostty |
| 3 | Music | Spotify, Tidal |
| 4 | Files | Thunar, Nautilus |
| 5 | Video | Oplide, mpv |
| 6 | System | VirtualBox |
| 7 | Mail | Franz |
| 8 | Games | Steam, emulators |
| 9 | Chat | Firefox Dev, notifications |
| 10 | Other | Map, tools |

## Directory Structure

```
~/.dotfiles/
├── my-configs
│   ├── config
│   ├── direnv
│   ├── dunst
│   ├── i3
│   ├── mpv
│   ├── nautilus
│   ├── picom
│   ├── polybar
│   ├── rofi
│   ├── tmux
│   ├── tmuxinator
│   ├── tmux-powerline
│   └── zathura
├── oh-my-zsh/
│   ├── lib/
│   ├── themes/
│   └── templates/
├── shell-basics
│   ├── dot-XCompose
│   ├── dot-xprofile
│   ├── dot-Xresources
│   ├── dot-xsessionrc
│   ├── dot-zshAlias
│   └── dot-zshrc
└── extras/
    └── config/
```

---

## License

MIT License - see LICENSE file for details.
