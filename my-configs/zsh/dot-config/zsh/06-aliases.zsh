# general
#
alias la="ls -a"
alias ll="ls -l"

#git
if (( $+commands[git] )); then
	alias ga="git add"
	alias gaa="git add -A"
  alias gc="git commit"
	alias gcl="git clone"
	alias gcm="git commit -m"
	alias gco="git checkout"
	alias gcob="git checkout -b"
	alias gd="git diff"
	alias gf="git fetch"
	alias gs="git status -sb"
  alias gst=gs
	alias ggpush="git push"
  alias gcam='git commit --all --message'
	alias ggpull="git pull"
fi

