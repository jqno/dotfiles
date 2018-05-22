alias cd..='cd ..'
alias vanilla-vim="vim -u NONE -U NONE -N"

alias gitk-old='/usr/local/bin/gitk'
alias gitk='echo "Use tig!"'
alias gst='git status'

# So we can type `git add *Test*` instead of `git add "*Test*"`
alias git="noglob git"


if [[ "$(uname -s)" == "Darwin" ]]
then
  alias ctags="`brew --prefix`/bin/ctags"
fi

