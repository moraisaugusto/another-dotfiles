# Another Dotfiles


__Another dotfiles__ is a collection of ZSH and VIM configurations based on [robbyrussell/oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) and Personal settings.

### Preview (Arch, i3, vim...)

![screen 1](https://raw.githubusercontent.com/aflavio/another-dotfiles/master/imgs/screenX.png)
![screen 2](https://raw.githubusercontent.com/aflavio/another-dotfiles/master/imgs/screen2.png)
![screen 1](https://raw.githubusercontent.com/aflavio/another-dotfiles/master/imgs/screen1.png)
![screen 4](https://raw.githubusercontent.com/aflavio/another-dotfiles/master/imgs/screen4.png)


### Prerequisites

* Linux (tested on Debian and Arch)
* [Zsh](http://www.zsh.org)
* `wget`
* `git`
* `vim`
* `xsel` # for copy/paste tmux/X11


### Fonts ###

* Gnome
    https://github.com/powerline/fonts
    * Interface: Meslo LG L for Powerline RegularForPowerline - 10
    * Window Titles: Meslo LG L DZ for Powerline Bold - 11
    * Documents: Sans Regular - 11 (default)
    * Monospace: Monospace Regular - 11 (default)
    * Terminal (guake): Source Code Pro for Powerline - 10 
    * Guake (color scheme): Frontend Delight


### Gnome (I don't use gnome anymore) ###

* GTK theme configuration

#### Dump Gnome current confs ####
$ gconftool-2 --dump / > gconf_dump.xml
$ gconftool-2 --unload clean-settings.xml

#### Load Gnome confs ####
$ gconftool-2 --load gconf_dump.xml

* Tweaks
    * Global Dark Theme: On
    * Icons: Numix-Circle
    * Theme: Adwaita (default)

### Installation ###

Download the following install file and run it. 

```shell
bash -c "$(wget https://raw.githubusercontent.com/aflavio/another-dotfiles/master/install.sh -O -)"
```
 When the installation finish, do:
 
 ```shell
source .zshrc
```
 
#### Init.d Scripts ###
Added a script that restart (unload/load) ethernet drive. It's usefull for r8169 ethernet drive when the system is resumed from suspended state.

#### Enabling Plugins ###

The install file automatically download and install all vim Plugins. Normally, you don't need run the command: vim +Pluginstall +qall. But, if it's fails, run again. 

### Themes ###

Default themes are: agnoster for ZSH and solarized dark for vim. 

#### Selecting a Theme ####

ZSH

Edit the .zshrc and change the line:

```shell
ZSH_THEME="agnoster"
```

VIM

Edit the .vimrc and change the line:

```shell
let g:airline_theme='solarized' # Check the others themes
colorscheme solizared 
```

Vim Themes are based on Airline [vim-airline/vim-airline](https://github.com/vim-airline/vim-airline). There are some Colorscheme installed too [Tomorrow](https://github.com/chriskempson/tomorrow-theme). 

### Components ###

#### i3 Window Manager ####

This dotfiles repository includes configuration for the i3 window manager. The configuration includes:

* Custom keybindings for window management
* Workspace configuration with icons
* Default applications for different workspaces
* Custom status bar integration

[i3 GitHub Repository](https://github.com/i3/i3)

#### Picom Compositor ####

Picom is configured as the compositor for the desktop environment. The configuration includes:

* Transparency effects
* Shadows
* Animations
* Performance optimizations

[Picom GitHub Repository](https://github.com/yshui/picom)

#### Polybar ####

Polybar is configured as the status bar for i3. The configuration includes:

* System information display (CPU, memory, temperature)
* Network status
* Volume control
* Battery status
* Date and time
* Workspace indicators

[Polybar GitHub Repository](https://github.com/polybar/polybar)

#### Rofi ####

Rofi is configured as the application launcher. The configuration includes:

* Custom themes and appearance
* Application launcher
* Window switcher
* Run dialog

[Rofi GitHub Repository](https://github.com/davatorium/rofi)

#### Dunst ####

Dunst is configured as the notification daemon. The configuration includes:

* Notification appearance and positioning
* Timeout settings
* Behavior customization

[Dunst GitHub Repository](https://github.com/dunst-project/dunst)

#### Tmux ####

Tmux is configured with:

* Custom keybindings
* Status bar configuration
* Session management
* Copy/paste enhancements

[Tmux GitHub Repository](https://github.com/tmux/tmux)

#### Direnv ####

Direnv is configured to automatically load environment variables based on the current directory. The configuration includes:

* Automatic environment loading
* Project-specific settings

[Direnv GitHub Repository](https://github.com/direnv/direnv)

#### Zsh Custom Themes ####

Custom zsh themes are included in the zsh-custom directory. The configuration includes:

* Custom prompt styling
* Theme customization
* Environment integration

#### Vim Configuration ####

The vim configuration includes:

* Plugin management with vim-plug
* Custom keybindings
* Syntax highlighting
* Performance optimizations
* Theme customization

#### System Configuration ####

System configuration includes:

* Keyboard layout settings
* Environment variables
* Path configurations
* Hardware-specific settings

[Nautilus GitHub Repository](https://github.com/GNOME/nautilus)

```
colorscheme solizared 
```

Vim Themes are based on Airline [vim-airline/vim-airline](https://github.com/vim-airline/vim-airline). There are some Colorscheme installed too [Tomorrow](https://github.com/chriskempson/tomorrow-theme). 


### Recommend tools ###

Network (Wifi and Ethernet)
* connman | connman-gtk (Aur)

### License ###

Another Dotfiles is released under the [MIT license](https://raw.githubusercontent.com/aflavio/another-dotfiles/master/LICENSE).
