#!/bin/bash


# -- Repo configuration
DOTFILES_REPO="https://github.com/moraisaugusto/another-dotfiles"
DOTFILES_DIR="$HOME/DOTFILES"
NVIM_REPO="https://github.com/moraisaugusto/nvim"
NVIM_DIR="$HOME/.config/nvim"
NVIM_DIR_BACKUP="$HOME/.config/nvim-backup"

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

loaderSpinner() {
    local pid=$!
    local msg=$1
    local delay=0.1
    # Braille frames from the 'dots' spinner style
    local frames=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
    
    # Hide the cursor so it doesn't flicker
    tput civis 

    while kill -0 "$pid" 2>/dev/null; do
        for frame in "${frames[@]}"; do
            # \r moves cursor to start, \033[K clears the line
            printf "\r \033[36m%s\033[0m %s" "$frame" "$msg"
            sleep "$delay"
            
            # Check again inside the loop to finish instantly when the PID dies
            if ! kill -0 "$pid" 2>/dev/null; then
                break
            fi
        done
    done

    # Restore cursor and print final status
    tput cnorm
    printf "\r \033[32m✔\033[0m %s\n" "$msg"
}



main() {
    printf "\n${BOLD}[INSTALLING] ${NORMAL}\n"
    #
    (git clone -q $DOTFILES_REPO $DOTFILES_DIR) & loaderSpinner " Clonning another dotfiles..."
    #
    cd $DOTFILES_DIR 
    (git submodule update --init --recursive -q)  & loaderSpinner " Clonning submodules (including oh-my-zsh)..."
}

vimInstallation() {
    printf "\n"
    promptConfirm "Do you want to install vim configuration? (y/n) " || exit 0

    printf "\n${BOLD}${BLUE}[NOTE]\n"
    printf "${NORMAL}Vim configuration will be cloned in your ${BOLD}$HOME/.config/nvim folder.\n"

    if [ ! -d "$NVIM_DIR" ]; then

      printf "${NORMAL}Press any key to continue or abort (ctrl+c)\n"
      read pause
      (git clone $NVIM_REPO $NVIM_DIR -q) & loaderSpinner " Clonning another vim configuration..."

    else
      printf "\n${BOLD}${YELLOW}[REQUIREMENT]\n"
      printf "${NORMAL}${BOLD}$HOME/.config/nvim${NORMAL} folder is not empty.\n"
      printf "\n"
      promptConfirm "${NORMAL}Do you want to back up your current vim configuration? (y/n) " || exit 0

      mv $NVIM_DIR $NVIM_DIR_BACKUP
      (git clone $NVIM_REPO $NVIM_DIR -q) & loaderSpinner " Clonning another vim configuration..."
    fi
}

suggestionMessage() {
    printf "\n"
    printf "\n${BOLD}${BLUE}[SUGGESTIONS] \n"
    printf "${NORMAL}\xE2\x97\x86 ${NORMAL} Use ${BOLD}'Source Code Pro for Powerline'${NORMAL} as terminal font\n"
    printf "\xE2\x97\x86 ${BOLD} Logout from all sessions${NORMAL} to reload your .zshrc \n"
    printf "   (sometimes only source ./zshrc doesn't work well)'\n"
    printf "${BOLD}\xE2\x97\x86 ${NORMAL} If you want, you can install Vim Plugins ${BOLD}in the end \n"
    printf "   of this installation \n"
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
    printf "${BOLD}\t Contact: ${NORMAL}${BOLD}hi@morais.io${NORMAL}\n\n"
}



clear
splash
promptConfirm "Continue ? (y/n): " || exit 0
suggestionMessage
main
bye
vimInstallation

