# Variables
STOW = stow
STOW_FLAGS = --dotfiles -v
STOW_VERBOSE_FLAGS = --dotfiles -vv
CONFIG_DIR = my-configs
TARGET = $(HOME)

# List of all packages inside my-configs
PACKAGES = config direnv dunst i3 mpv nautilus picom polybar rofi tmux tmux-powerline zathura

# Set default target to help (prevents accidental installation)
.DEFAULT_GOAL := help

.PHONY: all shell configs delete help $(PACKAGES)

## Install everything (shell-basics and all app configs)
install-all: shell configs 

# Install the root-level shell-basics
shell:
	$(STOW) $(STOW_FLAGS) shell-basics

# Install all packages from my-configs
configs: shell $(PACKAGES)

# Rule for individual packages in my-configs
$(PACKAGES):
	$(STOW) $(STOW_VERBOSE_FLAGS) -d $(CONFIG_DIR) -t $(TARGET) $@

# Remove all symlinks (Unstow)
delete:
	$(STOW) -D $(STOW_FLAGS) shell-basics
	$(STOW) -D -d $(CONFIG_DIR) -t $(TARGET) $(PACKAGES)

# Help menu
help:
	@echo "Usage:"
	@echo "  make all      - Install shell-basics and all configs"
	@echo "  make shell    - Install shell-basics only"
	@echo "  make configs  - Install all app configs from my-configs/"
	@echo "  make <app>    - Install a specific app (e.g., make i3)"
	@echo "  make delete   - Remove all symlinks"
