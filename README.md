# Another Dotfiles


__Another dotfiles__ is a collection of ZSH and VIM configurations based on [robbyrussell/oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) and [nicknisi/dotfiles](https://github.com/nicknisi/dotfiles). 

### Prerequisites

* Linux (tested on Debian)
* [Zsh](http://www.zsh.org)
* `wget`
* `git`
* `vim`

### Installation

Download the following install file and run it. 

```shell
sh -c "$(wget https://raw.githubusercontent.com/aflavio/another-dotfiles/master/install.sh -O -)"
```

#### Enabling Plugins

The install file automatically download and install all vim Plugins. Normally, you don't need run the command: vim +Pluginstall +qall. But, if it's fails, run again. 

```shell
vim +PlugInstall +qall
```

### Themes

Default themes are: agnoster for ZSH and solarized dark for vim. 

#### Selecting a Theme

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

Vim Themes are based on Airline [bling/vim-airline](https://github.com/bling/vim-airline). There are some Colorscheme installed too [Tomorrow](https://github.com/chriskempson/tomorrow-theme). 


![Shell](http://augustomorais.com.br/shell.png)

![Vim](http://augustomorais.com.br/vim.png)


## License

Another Dotfiles is released under the [MIT license](https://raw.githubusercontent.com/aflavio/another-dotfiles/master/LICENSE).
