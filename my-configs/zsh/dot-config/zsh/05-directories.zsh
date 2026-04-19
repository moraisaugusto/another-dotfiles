# 1. Options
setopt auto_cd           # Typing a directory name moves you there
setopt auto_pushd        # Track dir history
setopt pushd_ignore_dups # No duplicates in history
setopt pushdminus        # Makes -1, -2 match the 'd' list

# 2. Global Dot Aliases
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

# 3. The "View" command
alias d='dirs -v'
