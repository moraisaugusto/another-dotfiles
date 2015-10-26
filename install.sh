#!/bin/bash

main() {
    $DOTFILES=$HOME/.dotfiles

    # setting colors
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"

    # clonnig repositories
    printf "${GREEN}"
    echo 'Clonning Respository...'
    git clone https://github.com/aflavio/another-dotfiles.git .dotfiles
    cd .dotfiles
    git submodule update --init --recursive 
    echo 'done.'
    printf "${NORMAL}"

    # creating symlinks
    printf "${GREEN}"
    echo 'Installing...'
    ln -s $HOME/vim .vim
    linkables=$( find -name '*.symlink' )
    
    for file in $linkables ; do
        target="$HOME/.$( basename $file ".symlink" )"
        ln -s $DOTFILES/$file $target
    done

    echo 'done.'
    printf "${NORMAL}"


    printf "${BLUE}" 
    echo '██      ▄   ████▄    ▄▄▄▄▀ ▄  █ ▄███▄   █▄▄▄▄          '
    echo '█ █      █  █   █ ▀▀▀ █   █   █ █▀   ▀  █  ▄▀          '
    echo '█▄▄█ ██   █ █   █     █   ██▀▀█ ██▄▄    █▀▀▌           '
    echo '█  █ █ █  █ ▀████    █    █   █ █▄   ▄▀ █  █           '
    echo '   █ █  █ █         ▀        █  ▀███▀     █            '
    echo '  █  █   ██                 ▀            ▀             '
    echo ' ▀                                                     '
    echo '██▄   ████▄    ▄▄▄▄▀ ▄████  ▄█ █     ▄███▄     ▄▄▄▄▄   '
    echo '█  █  █   █ ▀▀▀ █    █▀   ▀ ██ █     █▀   ▀   █     ▀▄ '
    echo '█   █ █   █     █    █▀▀    ██ █     ██▄▄   ▄  ▀▀▀▀▄   '
    echo '█  █  ▀████    █     █      ▐█ ███▄  █▄   ▄▀ ▀▄▄▄▄▀    '
    echo '███▀          ▀       █      ▐     ▀ ▀███▀             '
    echo '                       ▀                               '
    echo 'Installing...' 
    printf "${NORMAL}"

  #env zsh
}

main










#echo "Initializing submodule(s)"
#git submodule update --init --recursive



#"echo "Configuring zsh as default shell"
#"chsh -s $(which zsh)

#"echo "Done."
