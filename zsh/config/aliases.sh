# General
alias cd..='cd ..'

# Vim
alias vanilla-vim="vim -u NONE -U NONE -N"

# Git
alias gitk-old='/usr/local/bin/gitk'
alias gitk='echo "Use tig!"'
alias gst='git status'
alias git="noglob git"   # So we can type `git add *Test*` instead of `git add "*Test*"`

# Java
alias setjdk='. setjdk.sh'
alias mvn='mvn -C'
alias runjava=runjava.py

# setEnv
alias session="source ~/.setEnv/session.sh"
alias work='. setEnv.sh work'
alias home='. setEnv.sh home'

# bat: a better `cat`
alias cat=bat

# exa: a better `ls`
alias ls=exa
alias lsa='exa -abghHliS'
alias tree='exa --tree'

# mcd
function mcd() {
  mkdir -p -- "$1" && cd -P -- "$1"
}

# MacOS pre-installs a bad version of ctags so we substitute our own.
if [[ "$(uname -s)" == "Darwin" ]]
then
  alias ctags="`brew --prefix`/bin/ctags"
fi

