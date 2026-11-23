
if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
else
  PROMPT='%F{blue}%~%f %# '
fi
