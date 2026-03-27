# ⚡ Another Dotfiles

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/platform-linux-lightgrey)](https://www.kernel.org/)
[![Shell](https://img.shields.io/badge/shell-zsh-89e051)](https://www.zsh.org/)
[![Editor](https://img.shields.io/badge/editor-vim-019733)](https://www.vim.org/)

A curated collection of ZSH and Vim configurations optimized for a lightweight **Arch + i3** workflow. Heavily inspired by [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh), originally built for GNOME and evolved into a minimal, keyboard-driven setup.

---

## ✨ Features

- **ZSH** — custom aliases, functions, and a clean prompt
- **Vim** — opinionated config with plugins for productivity
- **i3wm** — tiling window manager keybinds and layout
- **Polybar** — status bar with modular blocks
- **One-line installer** — get up and running in seconds

---

## 🚀 Quick Start

> [!WARNING]
> The install script will **overwrite** existing configs for `.zshrc`, `.vimrc`, and related dotfiles. Back up your current setup before proceeding.

**Option 1 — wget (recommended):**
```shell
bash -c "$(wget https://raw.githubusercontent.com/aflavio/another-dotfiles/master/install.sh -O -)"
```

**Option 2 — curl:**
```shell
bash -c "$(curl -fsSL https://raw.githubusercontent.com/aflavio/another-dotfiles/master/install.sh)"
```

---

## 🛠️ What Gets Installed

| Component | Target Path | Description |
| --- | --- | --- |
| `.zshrc` | `~/.zshrc` | ZSH config with aliases & prompt |
| `.vimrc` | `~/.vimrc` | Vim config with plugins |
| `i3/config` | `~/.config/i3/config` | i3wm keybinds & layout |
| `polybar/` | `~/.config/polybar/` | Polybar theme & modules |

---

## 📋 Requirements

- Arch Linux (or any systemd-based distro)
- `zsh`, `vim`, `i3`, `polybar`
- `wget` or `curl`
- `git`

---

## 🤝 Contributing

Issues and PRs are welcome. If you have a clean config improvement or a new module, feel free to open a pull request.

---

## 📄 License

[MIT](https://opensource.org/licenses/MIT) © [aflavio](https://github.com/aflavio)
