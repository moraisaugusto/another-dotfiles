#!/bin/bash

set -e
# setting colors
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
GRAY="$(tput setaf 7)"
YELLOW="$(tput setaf 3)"
BLUE="$(tput setaf 4)"
BOLD="$(tput bold)"
NORMAL="$(tput sgr0)"




# Function to draw progress bar
progressBar () {

  # Calculate number of fill/empty slots in the bar
  progress=$(echo "$progressBarWidth/$taskCount*$tasksDone" | bc -l)
  fill=$(printf "%.0f\n" $progress)
  if [ $fill -gt $progressBarWidth ]; then
    fill=$progressBarWidth
  fi
  empty=$(($fill-$progressBarWidth))

  # Percentage Calculation
  percent=$(echo "100/$taskCount*$tasksDone" | bc -l)
  percent=$(printf "%0.2f\n" $percent)
  if [ $(echo "$percent>100" | bc) -gt 0 ]; then
    percent="100.00"
  fi

  # Output to screen
  printf "\r["
  printf "%${fill}s" "" | sed 's/ /\xE2\x96\x89/g'
  printf "%${empty}s" "" | sed 's/ /\xE2\x96\x91/g'
  printf "] $percent%% - $text "
}





## Collect task count
#taskCount=33
#tasksDone=0
#
#while [ $tasksDone -le $taskCount ]; do
#
#  # Do your task
#  (( tasksDone += 1 ))
## Add some friendly output
#  text=$(echo "somefile-$tasksDone.dat")
#
#  # Draw the progress bar
#  progressBar $taskCount $taskDone $text
#
#  sleep 0.01
#done
#
#echo


checkShell() {
    if [ ! -z "$ZSH_VERSION" ]; then
        printf "${BOLD}${RED}ZSH Shell is not actived!\n"
        printf "${NORMAL}Install it from your package manager\n"
        printf "${NORMAL}After installed, set ZSH as default shell:\n\n"
        printf "\t${GREEN}${BOLD}~\$${NORMAL}${GREEN} sudo chsh -s $(which zsh) $(whoami)\n\n${NORMAL}"
        exit
    fi
}

printShellCmd() {
  printf "\n\t${GREEN}${BOLD}~\$${NORMAL}${GREEN} $1\n\n${NORMAL}"
}

checkCmds() {
    local_dirs=("$@")

    for (( i = 0 ; i < ${#local_dirs[@]} ; i++ ))
        do
            if [ ! -x "$(command -v ${local_dirs[$i]})" ]; then
                printf "${BOLD}${RED}${local_dirs[$i]}${NORMAL}${BOLD} command is not installed!\n"
                printf "${NORMAL}Please, install it from your package manager\n"
            fi
    done

}
checkRequisites() {
    commands=("wget" "git" "vim" "xsel")

    checkShell
    checkCmds "${commands[@]}"
}

checkDirectories() {
    local_dirs=("$@")

    for (( i = 0 ; i < ${#local_dirs[@]} ; i++ ))
        do
            if [ ! -d "$i" ]; then
                mkdir ${local_dirs[$i]}
            fi
    done
}
promptConfirm() {
  while true; do
    read -r -n 1 -p "${1}" REPLY
    case $REPLY in
      [yY]) echo; return 0 ;;
      [nN]) echo; return 1 ;;
      *) printf "\n ${RED}${BOLD}Dude! ${NORMAL}${RED}Do you have a problem? 
       Answer 'y' or 'n' (without single quotation marks)!${NORMAL}\n"
    esac
  done
}

checkSymlink() {
    if [ ! -L $2 ] || [ ! -e $2 ] ; then
        ln -s $1 $2
    else
        printf "\n\t${BOLD}${RED}$2${NORMAL}${BOLD} already exists!\n\t"

        promptConfirm "${NORMAL}Do you want backup it and continue with the installation? (y/n):" || exit 0
        printf "\t${BOLD}Backup done: ${NORMAL}$2-old\n\n"
        mv $2 $2-old
    fi
}



loaderSpinner()
{
    local pid=$!
    local delay=0.5
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf "\t [%c%c] $1" "$spinstr" "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf '\b%.0s' {1..60}
    done
    printf "\t${BOLD}${GREEN} [OK] ${NORMAL}$1\n"
}



main() {
    printf "\n${BOLD}[INSTALLING] ${NORMAL}\n"
    # vars
    DOTFILES=$HOME/.dotfiles

    checkRequisites

    # create directories
    directories=(".dotfiles" ".fonts")

    # checking directories
    checkDirectories "${directories[@]}" & loaderSpinner " Checking directories..."

    (git clone -q https://github.com/aflavio/another-dotfiles.git .dotfiles) & loaderSpinner " Clonning another dotfiles..."

    cd .dotfiles
    (git submodule update --init --recursive)  & loaderSpinner " Clonning submodules (including oh-my-zsh)..."
    cd ..

    # creating symlinks
    checkSymlink $DOTFILES/vim $HOME/.vim
    checkSymlink $DOTFILES/fonts .fonts
    checkSymlink $DOTFILES/extras/oh-my-zsh/custom/themes $DOTFILES/oh-my-zsh/custom/themes
    checkSymlink $DOTFILES/extras/oh-my-zsh/custom/plugins/tmux $DOTFILES/oh-my-zsh/custom/plugins/tmux
    checkSymlink $DOTFILES/symlinkis/zshAlias.symlink $HOME/.zshAlias

    linkables=$( find -H "$DOTFILES" -name '*.symlink' )
    for file in $linkables ; do
        target="$HOME/.$( basename $file ".symlink" )"
        checkSymlink $file $target
    done
    mv $HOME/.tmux $HOME/.tmux.conf

    printf "${BOLD}${GREEN}\t [OK] ${NORMAL} Creating symlinks...${NORMAL}\n"

    #source $HOME/.zshrc

    ## copying init.d script files
    #promptConfirm "Do you want to install extra scripts (needs root permission)? (y/n): " || exit 0
    #sudo checkSymlink $DOTFILES/scripts/init.d/reset-ethernet.sh /etc/init.d/reset-ethernet.sh
}

vimInstallation() {
    printf "\n"
    promptConfirm "Do you want to install vim dotfiles? (y/n) " || exit 0

    printf "\n${BOLD}${YELLOW}[WARNING] ${NORMAL}${BOLD}Sometimes when clonning vim plugin the installation can broke.\n"
    printf "${NORMAL}\t  Then you need to run this command manually:\n"
    printShellCmd "vim +PlugInstall"
    printf "${NORMAL}Press any key to continue\n"
    read pause

    vim +PlugInstall +qall
}

suggestionMessage() {
    printf "\n"
    printf "\n${BOLD}${BLUE}[SUGGESTIONS] \n"
    printf "${NORMAL}\t\xE2\x97\x86 ${NORMAL} Use ${BOLD}'Source Code Pro for Powerline'${NORMAL} as terminal font\n"
    printf "\t\xE2\x97\x86 ${BOLD} Logout from all sessions${NORMAL} to reload your .zshrc \n"
    printf "\t   (sometimes only source ./zshrc doesn't work well)'\n"
    printf "${BOLD}\t\xE2\x97\x86 ${NORMAL} If you want, you can install Vim Plugins ${BOLD}in the end \n"
    printf "\t   of this installation \n"
    printf "${NORMAL}\n"
}

splash() {
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
    printf "${NORMAL}"
    printf "${BOLD}Welcome to Another dotfiles installation${NORMAL}\n\n"
}

bye() {
    printf "\n${BOLD}${GREEN}[SUCCESS]\n\t${NORMAL} ${BOLD}Now you have the dotfiles configured!${NORMAL}\n"
    printf "${BLUE}${BOLD}\t Thanks for installing Another Dotfiles\n"
    printf "${BOLD}\t Contact: ${NORMAL}${BOLD}aflavio at gmail.com${NORMAL}\n\n"
}



clear
splash
promptConfirm "Continue ? (y/n): " || exit 0
suggestionMessage
main
bye
vimInstallation

