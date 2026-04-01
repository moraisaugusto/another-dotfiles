# ⚡ Another Dotfiles

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/platform-linux-lightgrey)](https://www.kernel.org/)
[![Shell](https://img.shields.io/badge/shell-zsh-89e051)](https://www.zsh.org/)
[![Editor](https://img.shields.io/badge/editor-vim-019733)](https://www.vim.org/)
[![Window Manager](https://img.shields.io/badge/i3wm-modified-blue)](https://i3wm.org/)
[![Terminal](https://img.shields.io/badge/tmux-256color-4477aa)](https://tmux.github.io/)
[![Status Bar](https://img.shields.io/badge/polybar-modular-ff6653)](https://polybar.github.io/)
[![Launcher](https://img.shields.io/badge/rofi-configurable-e436f0)](https://davedavenport.github.io/rofi/)

A curated collection of dotfiles optimized for a lightweight **Arch + i3wm** workflow. This repository contains professional configurations for i3 window manager, tmux terminal multiplexer, polybar status bar, rofi launcher, and more—all designed for keyboard-driven productivity.

---

## ✨ Features

### **i3 Tiling Window Manager**
- Keyboard-driven workflow with modifier key (Mod4/Super)
- Custom workspace configuration with icons
- Application-specific window rules and focus settings
- Multimedia key bindings for audio and media controls
- Custom keybindings for window management
- Auto-start configuration for common applications
- Integrated lock screen and monitoring setup
- Background wallpapers support

### **tmux Terminal Multiplexer**
- 256-color terminal output for modern look
- Vi-style keybindings for navigation and editing
- Custom prefix key (Ctrl+a)
- Mouse support for better interaction
- Pane synchronization across multiple windows
- Clipboard integration with xsel
- SSH authentication forwarding
- Terminal title management
- Copy/paste operations with color support

### **polybar Status Bar**
- Modular design with customizable modules
- Real-time system information:
  - CPU and memory usage
  - Battery status and charging animation
  - Temperature monitoring
  - Network interface (WiFi and Ethernet)
  - Disk usage tracking
  - Time and date display
  - Active workspace indicator
  - Update notifications (Arch-specific)
- Custom modules for audio (pipewire)
- Network tools (tailscale, mullvad-vpn)
- Power management menu
- Monitor configuration controls
- Weather module for location-based forecasts

### **rofi Application Launcher**
- DRun mode for application launching
- Run mode for command execution
- SSH mode for quick terminal connections
- Window mode for active window switching
- Custom search and display options
- Themed squared-nord design
- Quick keybindings for rapid access

### **Additional Components**
- ZSH configuration with oh-my-zsh base
- Vim setup with plugin manager
- Dunst notification daemon
- Picom compositor configuration
- i3lock for secure screen locking

---

## 🚀 Installation Methods

### **Method 1: Using stow (Recommended)**

The dotfiles are organized in a way that works perfectly with GNU Stow, a tool that manages dotfiles via symlinks.

#### **Prerequisites**

```bash
# Install stow if not already available
sudo pacman -S stow  # Arch Linux
# or
sudo apt install stow  # Debian/Ubuntu
# or
```

#### **Installation Steps**

1. **Clone the repository:**
```bash
cd ~/
git clone https://github.com/aflavio/another-dotfiles.git dotfiles
cd dotfiles
```

2. **Install git submodules:**
```bash
git submodule update --init --recursive
```

3. **Stow the dotfiles:**
```bash
# Stow all configuration files
stow .

# Or stow individually for specific components:
stow i3    # Window manager configuration
stow tmux  # Terminal multiplexer
stow polybar  # Status bar
stow rofi  # Application launcher
stow zsh   # Shell configuration
stow vim   # Editor configuration
```

4. **Restart your shell or logout/login:**
```bash
exec zsh
# or
source ~/.zshrc
```

That's it! All dotfiles will now be symlinked to your home directory.

---

### **Method 2: Manual Installation**

For those who prefer not to use stow, you can manually create symlinks:

```bash
cd ~
git clone https://github.com/aflavio/another-dotfiles.git dotfiles
cd dotfiles
git submodule update --init --recursive

# Create config directory if it doesn't exist
mkdir -p ~/.config/i3
mkdir -p ~/.config/polybar
mkdir -p ~/.config/tmux
mkdir -p ~/.config/rofi

# Create symlinks
ln -s $(pwd)/i3/.config/i3/config ~/.config/i3/config
ln -s $(pwd)/tmux/.config/tmux/tmux.conf ~/.config/tmux/tmux.conf
ln -s $(pwd)/tmux/.config/tmux/tmux-linux.conf ~/.config/tmux/tmux.conf
ln -s $(pwd)/polybar/.config/polybar/config.ini ~/.config/polybar/config.ini
ln -s $(pwd)/rofi/.config/rofi/config.rasi ~/.config/rofi/config.rasi
```

### **Method 3: Using the Install Script**

Download and execute the provided install script:

```bash
# Using wget
bash -c "$(wget https://raw.githubusercontent.com/aflavio/another-dotfiles/master/install.sh -O -)"

# Using curl
bash -c "$(curl -fsSL https://raw.githubusercontent.com/aflavio/another-dotfiles/master/install.sh)"
```

**Note:** The install script will replace existing configuration files. **Always backup your current configuration** before running it.

---

## 📋 Requirements

### **Core Dependencies**
- **Linux distribution:** Arch Linux or any systemd-based distro with systemd
- **Window manager:** i3 (or i3-gaps) version 4+
- **Shell:** ZSH version 5+
- **Terminal:** Any terminal emulator (recommended: URXVT, Termite, Ghostty)
- **Clipboard:** xsel or xclip

### **Required Packages (Arch Linux)**

```bash
sudo pacman -S \
  i3 \
  i3-gaps \
  polybar \
  rofi \
  zsh \
  vim \
  dunst \
  picom \
  scrot \
  feh \
  xsel \
  git \
  tmux \
  xautolock \
  i3lock \
  archlinux-wallpaper \
  networkmanager \
  pulseaudio \
  pamixer \
  brightnessctl
```

### **Recommended Packages**

```bash
sudo pacman -S \
  archlinux-wallpaper \
  rofi \
  picom \
  dunst \
  feh \
  rofi \
  tmux \
  zsh \
  vim \
  git \
  alacritty \
  urxvt \
  pulseaudio-pulse \
  playerctl \
  mpv \
  audacious \
  fff \
  exa \
  bat \
  delta \
  ripgrep \
  fd-find \
  tealdeer \
  jq \
  wget \
  curl \
  aria2 \
  picom \
  maim \
  slop \
  ffmpeg \
  youtube-dl
```

### **Optional VPN Tools**
- **tailscale:** For secure VPN connectivity
```bash
sudo pacman -S tailscale
```

- **mullvad-vpn:** For Mullvad VPN service
```bash
sudo pacman -S mullvad-vpn
```

---

## 🗂️ Directory Structure

```
~/.dotfiles/
├── i3/                         # i3 window manager configuration
│   └── .config/
│       └── i3/
│           └── config          # Main i3 configuration file
├── tmux/                       # tmux terminal configuration
│   └── .config/
│       └── tmux/
│           ├── tmux.conf       # Symlink to tmux-linux.conf
│           ├── tmux-linux.conf # Linux-specific tmux config
│           └── tmux-macos.conf # macOS-specific tmux config
├── polybar/                    # Polybar status bar configuration
│   └── .config/
│       └── polybar/
│           ├── config.ini      # Main polybar configuration
│           └── launch.sh       # Polybar launcher script
├── rofi/                       # Rofi application launcher
│   └── .config/
│       └── rofi/
│           └── config.rasi     # Rofi configuration file
├── zsh/                        # ZSH shell configuration
│   └── .zshrc                  # ZSH configuration file
├── vim/                        # Vim editor configuration
│   └── .vimrc                  # Vim configuration file
├── extras/                     # Additional configuration modules
│   ├── zsh/
│   │   └── custom/
│   │       ├── themes/         # Custom ZSH themes
│   │       └── plugins/        # Custom ZSH plugins
│   ├── i3/                    # i3-specific extras
│   ├── polybar-scripts/       # Polybar custom modules
│   └── tmux/                  # tmux-specific themes
└── install.sh                  # Automated installation script
```

---

## ⌨️ Keybindings

### **i3 Window Manager**

#### **Key Modifiers**
- **Mod4** (Super key / Windows key) - Primary modifier

#### **Basic Navigation**
```
Mod4+h - Move focus left
Mod4+j - Move focus down
Mod4+k - Move focus up
Mod4+l - Move focus right

Mod4+Left - Focus left
Mod4+Down - Focus down
Mod4+Up - Focus up
Mod4+Right - Focus right
```

#### **Window Management**
```
Mod4+Shift+q - Kill focused window
Mod4+-        - Split horizontally
Mod4+|        - Split vertically
Mod4+f        - Toggle fullscreen
Mod4+s        - Stack layout
Mod4+w        - Tabbed layout
Mod4+e        - Toggle split
Mod4+Space    - Focus next window
Mod4+Shift+Space - Toggle floating
```

#### **Workspace Navigation**
```
Mod4+1 to Mod4+0 - Switch to workspace 1-10
Mod4+Shift+1 to Mod4+Shift+0 - Move active window to workspace 1-10
```

#### **Application Launching**
```
Mod4+d           - Open rofi application launcher
Mod4+Return      - Open terminal (i3-sensible-terminal)
Mod4+F12         - Open terminal (URXVT)
```

#### **Resize Mode**
```
Mod4+r           - Enter resize mode
In resize mode: h/j/k/l - Resize window
```

#### **System Controls**
```
Mod4+Shift+r - Restart i3
Mod4+Shift+c - Reload i3 configuration
Mod4+Shift+e - Exit i3 (logout)
Mod4+Control+l - Lock screen
Mod4+Shift+e - Exit i3 (with confirmation)
```

#### **Multimedia Keys**
```
XF86AudioRaiseVolume - Increase volume
XF86AudioLowerVolume - Decrease volume
XF86AudioMute        - Toggle mute
XF86AudioPlay        - Play/Pause media
XF86AudioStop        - Stop media
XF86AudioNext        - Next track
XF86AudioPrev        - Previous track
```

#### **Other Actions**
```
Mod4+m - Move workspace to left monitor
Mod4+Shift+p - Show monitor configuration (arandr)
Mod4+Shift+s - Open audio settings (pavucontrol)
```

### **tmux Terminal Multiplexer**

#### **Key Modifiers**
- **Ctrl+a** - Primary prefix key

#### **Window Management**
```
Ctrl+a+c       - Create new window
Ctrl+a+n       - Next window
Ctrl+a+p       - Previous window
Ctrl+a+         - Tile all windows
Ctrl+a,r       - Reload tmux configuration
```

#### **Pane Management**
```
Ctrl+a|        - Split pane horizontally
Ctrl+a-        - Split pane vertically
Ctrl+a+h       - Move focus left
Ctrl+a+j       - Move focus down
Ctrl+a+k       - Move focus up
Ctrl+a+l       - Move focus right
Ctrl+a,y       - Synchronize all panes in window
Ctrl+a+o       - Switch to next pane
Ctrl+a+{       - Rotate window up
Ctrl+a+}       - Rotate window down
```

#### **Pane Resizing**
```
Ctrl+a+H       - Resize pane left (hold to continue)
Ctrl+a+J       - Resize pane down (hold to continue)
Ctrl+a+K       - Resize pane up (hold to continue)
Ctrl+a+L       - Resize pane right (hold to continue)
```

#### **Window Switching**
```
Ctrl+a+0-9     - Switch to window by number
Ctrl+a+w       - List windows
```

#### **Copying and Pasting**
```
Ctrl+a+[-c/v-  - Enter copy mode
Ctrl+a+v       - Paste from clipboard
```

#### **Navigation**
```
Ctrl+a,        - Switch to previous window
Ctrl+a+.       - Switch to next window
```

### **Polybar Status Bar**

#### **Module Interactions**
```
Click middle on pipewire module - Mute toggle
Scroll up on pipewire module - Volume up
Scroll down on pipewire module - Volume down
Click right on pipewire module - Open audio settings
Click left on tailscale module - Toggle tailscale
Click right on tailscale module - Stop tailscale
Click left on mullvad-vpn module - Toggle VPN
Click right on mullvad-vpn module - VPN menu
Click middle on mullvad-vpn module - Copy IP to clipboard
Click left on battery module - Recharge
Scroll down left/right on temperature - Decrease/increase brightness (if applicable)
```

#### **Monitor Configuration**
```
Click left on monitor module - Open arandr for monitor configuration
```

#### **Menu Actions**
```
Click on powermenu items: Reboot, Power off, Sleep, Log out, Lock
```

### **rofi Application Launcher**

```
Super+d         - Open rofi application launcher
Alt+d           - Open rofi run mode
Alt+t           - Open rofi SSH mode
Alt+w           - Open rofi window switcher
```

#### **Search Controls**
```
Enter            - Accept selection
Escape           - Cancel search
Ctrl+d           - Deselect all items
```

---

## ⚙️ Customization

### **Configuring i3**

#### **Customizing Workspaces**
Edit `~/.config/i3/config`:

```bash
# Modify workspace definitions
bindsym $mod+1 workspace 1
bindsym $mod+2 workspace 2
# ... additional workspaces

# Add custom icons
ws-icon-0 = 1;
ws-icon-1 = 2;
```

#### **Modifying App Rules**
```bash
# Assign specific apps to workspaces
assign [class="Brave"] 1
assign [class="urxvt"] 2
assign [class="Spotify"] 3
```

#### **Changing Keybindings**
```bash
# Replace with your preferred key combinations
bindsym Super+d exec rofi -show drun
```

#### **Background Images**
```bash
# Update wallpaper paths in i3 config
exec sleep 2 && feh --bg-fill /path/to/wallpaper.png
```

### **Configuring tmux**

#### **Changing Theme**
```bash
# Edit the theme file
~/.dotfiles/extras/tmux/themes/tmux-gruvbox-dark.conf
```

#### **Customizing Keybindings**
```bash
# Edit tmux config
vim ~/.config/tmux/tmux.conf

# Add custom bindings
bind-key -r u capture-pane -J -P -S 0-1000
```

#### **Changing Window Title Format**
```bash
# In tmux-linux.conf
set-option -g set-titles-string "#{pane_current_path}"
```

### **Configuring Polybar**

#### **Monitors Configuration**
Edit `~/.config/polybar/config.ini`:

```bash
# Update the monitor name
monitor = ${env:MONITOR:HDMI-1}

# Adjust module positioning
modules-left = i3 info-tailscale mullvad-vpn
modules-center = date
modules-right = cpu memory wlan eth battery
```

#### **Customizing Colors**
```bash
[colors]
background = #222          # Background hex color
background-alt = #444      # Alt background hex color
foreground = #dfdfdf      # Main foreground color
primary = #ffb52a         # Primary accent
secondary = #e60053       # Secondary accent
```

#### **Module-Specific Configs**

**Network:**
```bash
# Update WiFi interface
interface = wlp1s0f5

# Update Ethernet interface
interface = enp0s20f3
```

**Battery:**
```bash
# Update battery device
battery = BAT0
adapter = AC0
full-at = 98
```

**Temperature:**
```bash
# Update thermal zone
thermal-zone = 6
warn-temperature = 80
```

#### **Custom Modules**
Add your own modules by placing script files in:
```bash
~/.dotfiles/extras/config/polybar-scripts/polybar-scripts/your-module/
```

Then reference them in config.ini:
```bash
[module/your-module]
type = custom/script
exec = ~/.dotfiles/extras/config/polybar-scripts/polybar-scripts/your-module/your-script.sh
```

### **Configuring Rofi**

#### **Rasi Theme Modifications**
Edit `~/.config/rofi/config.rasi`:

```bash
configuration {
    font            : "Source Code Pro Regular 22";
    display-ssh     : "";
    display-run     : "";
    display-drun    : "";
    display-window  : "";
    drun-show-actions: true;
}

@theme "themes/squared-nord.rasi"
```

#### **Custom Search Modifiers**
```bash
# In the commented configuration section
drun-match-fields: "name,generic,exec,categories,keywords";
drun-show-actions: true;
drun-display-format: "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
```

#### **Accessibility**
```bash
# Enable keyboard navigation hints
kb-accept-entry: "Control+j,Control+m,Return,KP_Enter;Alt+1;Alt+2;Alt+3;Alt+4";
kb-mode-next: "Shift+Right,Control+Tab";
kb-mode-previous: "Shift+Left,Control+ISO_Left_Tab";
```

---

## 🔄 Updating and Maintenance

### **Updating Dotfiles**

```bash
# Update the repository
cd ~/.dotfiles
git pull

# Update specific submodule if needed
git submodule update --remote
```

### **Removing Dotfiles**

```bash
cd ~/.dotfiles
stow -t ~ -D .      # Remove all dotfiles
# or
stow -D i3          # Remove specific dotfile
stow -D tmux
stow -D polybar
stow -D rofi
```

### **Updating Packages**

```bash
# Arch Linux
sudo pacman -Syu

# Update Arch packages that have updates
sudo pacman -Suy
```

### **Backup Your Current Configuration**

```bash
# Before running install script or stowing
cp -r ~/.config/i3 ~/.config/backups/i3
cp -r ~/.config/tmux ~/.config/backups/tmux
cp -r ~/.config/polybar ~/.config/backups/polybar
cp -r ~/.config/rofi ~/.config/backups/rofi
```

---

## 🐛 Troubleshooting

### **i3 Issues**

**Blank screen or cannot start i3:**
```bash
# Check configuration
i3 --dry-run
# or
i3-msg reload
```

**Background not showing:**
- Ensure wallpaper directory exists
- Check file permissions on wallpaper
- Verify feh command in i3 config

**Applications not launching:**
- Check application names with `i3-msg -t get_tree`
- Verify window class matches assignment rules

### **tmux Issues**

**Tmux starts in weird mode:**
```bash
# Check for conflicting configurations
ls -la ~/.tmux.conf
# Remove conflicting file if needed
rm ~/.tmux.conf
```

**Copy-paste not working:**
- Ensure xsel is installed
- Check that tmux version supports your clipboard tool
- Try alternative: `tmux set-option -g default-clipboard "xsel"`

### **Polybar Issues**

**Polybar bar not showing:**
```bash
# Check logs
~/.config/polybar/launch.sh -d

# Verify monitor name
xrandr
```

**Module errors:**
- Check if required packages are installed
- Verify module script permissions: `chmod +x ~/.config/polybar-scripts/*/*/*.sh`
- Disable problematic module temporarily to test

### **Rofi Issues**

**Rofi not launching:**
```bash
# Check rofi installation
which rofi
rofi --version
```

**Theme not applying:**
- Verify theme file path in config
- Check rasi syntax: `rofi -show drun -themes /path/to/theme.rasi`

### **General Issues**

**SSH forwarding not working:**
- Check `/etc/ssh/sshd_config` (server side)
- Verify `~/.ssh/config` and permissions
- Ensure `SSH_AUTH_SOCK` is correctly set

**Clipboard problems:**
```bash
# Install clipboard tools
sudo pacman -S xsel xclip

# Test clipboard
echo "test" | xsel -i -p
xsel -o -p
```

---

## 🔗 Related Tools and Projects

- **i3-gaps:** Extended i3 with gap support
- **polybar-scripts:** Additional polybar modules
- **Arch Linux:** Distribution used for development
- **Stow:** Dotfile management tool (GNU)
- **Neofetch:** System information display
- **Ranger:** File manager
- **Vim plugin:** Vim configuration manager

---

## 📖 Additional Resources

- **[i3wm Documentation](https://i3wm.org/docs/)** - Official i3 documentation
- **[tmux Manual](https://man.archlinux.org/man/tmux.1.en)** - tmux official manual
- **[polybar Wiki](https://github.com/polybar/polybar/wiki)** - polybar documentation
- **[rofi - Rofi: A fork of dmenu](https://github.com/dave/dmenu)** - Rofi repository
- **[Awesome Dotfiles](https://github.com/webgeek1234/dotfiles)** - Dotfiles examples
- **[Waybar](https://github.com/Alexays/Waybar)** - Alternative status bar

---

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## 🤝 Contributing

Feel free to submit issues, fork the repository, and create pull requests for any improvements or custom configurations you'd like to share.

---

## 💬 Support

If you encounter any issues or have questions, please:
1. Check the Troubleshooting section
2. Search existing issues
3. Open a new issue with detailed information

---

## 🎯 Usage Tips

### **Productivity Shortcuts**
- Use `Mod4+d` to quickly launch applications without leaving i3
- Leverage `Ctrl+a` prefix in tmux for faster navigation
- Use pane synchronization (`Ctrl+a+y`) for simultaneous commands across panes
- Customize rofi modules to show your most-used applications

### **Optimization**
- Use 256-color terminals for better i3/tmux/polybar visuals
- Set up wallpapers in i3 config for personalized workspace
- Use tmux's session persistence to resume work later
- Configure polybar modules to display only what you need

### **Getting Started**
1. After installation, log out and back into i3
2. Open rofi with `Mod4+d` to explore apps
3. Try `Ctrl+a+c` (tmux new window) and `Ctrl+a+|` (split pane)
4. Customize keybindings in your preferred configuration files

---

**Enjoy your optimized command-line productivity! 🚀**