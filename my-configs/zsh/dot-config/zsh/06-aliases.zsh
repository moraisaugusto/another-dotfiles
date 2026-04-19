# general
#
alias la="ls -a"
alias ll="ls -l"

#git
if (( $+commands[git] )); then
	alias ga="git add"
	alias gaa="git add -A"
	alias gb="git branch"
  alias gc="git commit"
	alias gcl="git clone"
	alias gcm="git commit -m"
	alias gco="git checkout"
	alias gcob="git checkout -b"
	alias gcs="git commit -S -m"
	alias gd="git diff"
	# alias gdc="git difftool --cached"
	alias gf="git fetch"
	alias gg="git graph"
	alias ggg="git graphgpg"
	alias gm="git merge"
	alias gp="git push"
	alias gpr="gh pr create"
	alias gr="git rebase -i"
	alias gs="git status -sb"
  alias gst=gs
	alias gt="git tag"
	alias gu="git reset @ --" #think git unstage
	alias gx="git reset --hard @"
	alias ggpush="git push"
  alias gcam='git commit --all --message'
	alias ggpull="git pull"
fi

