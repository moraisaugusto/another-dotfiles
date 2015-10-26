# Another Dotfiles


__Another dotfiles__ is collection of ZSH and VIM configurations based on [robbyrussell/oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) and [nicknisi/dotfiles](https://github.com/nicknisi/dotfiles). 

### Prerequisites

* Linux (tested on Debian)
* [Zsh](http://www.zsh.org)
* `wget` should be installed
* `git` should be installed
* `vim` should be installed

### Installation

Download the follow install file and run it. 

```shell
sh -c "$(wget https://raw.githubusercontent.com/aflavio/another-dotfiles/master/install.sh -O -)"
```

#### Enabling Plugins

The install file automatically download and install all vim Plugins. Normally, you don't need run the command: vim +Pluginstall +qall. But, if it's fails, run again. 

```shell
vim +PlugInstall +qall
```

### Themes

By default, the agnoster for ZSH and solarized dark for vim. 

#### Selecting a Theme

ZSH

Edit the .zshrc and change the follow line:

```shell
ZSH_THEME="agnoster" # (this is one of the fancy ones)
```

VIM

Edit the .vimrc and change the line: 462 

```shell
let g:airline_theme='solizared' # Check the others themes
colorscheme solizared 
```

To change Airline Theme just change the line above [bling/vim-airline](https://github.com/bling/vim-airline). There is some colorscheme installed too [Tomorrow](https://github.com/chriskempson/tomorrow-theme). 


![Shell](https://augustomorais.com.br/shell.png)

![Vim](https://augustomorais.com.br/vim.png)


## License

Another Dotfiles is released under the [MIT license](https://raw.githubusercontent.com/aflavio/another-dotfiles/master/LICENSE).
