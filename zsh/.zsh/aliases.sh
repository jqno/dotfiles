#!/usr/bin/env bash

# General
alias cd..='cd ..'

# Modern alternatives to standard tools
alias cat='bat -pp'
alias df=duf
alias du=dust
alias ls='exa --icons'
alias MAN="$(which man)"
alias man=tldr
alias tree='exa --icons --tree'

# Vim
alias vim=nvim
alias vanilla-vim='vim -u NONE -U NONE -N'

# Git
alias gitk-old='/usr/local/bin/gitk'
alias gitk='echo "Use tig!"'
alias gst='git status'
alias git='noglob git'   # So we can type `git add *Test*` instead of `git add "*Test*"`
alias pr='gh pr create'
alias github='gh browse'

# Nix
alias ns=nix-shell

# Java
alias setjdk='. setjdk.sh'
alias runjava=runjava.py
alias pitest='mvn clean test org.pitest:pitest-maven:mutationCoverage'

# Docker
dockerstop() {
  local matches
  matches=$(docker ps --format '{{.ID}} {{.Image}}' | grep -F "$1")

  if [ "$(echo "$matches" | wc -l)" -gt 1 ]; then
    echo "Multiple containers match the query:"
    echo "$matches" | awk '{print "- " $0}'
    return 1
  fi

  docker stop $(echo "$matches" | awk '{print $1}')
}

# mcd
function mcd() {
  mkdir -p -- "$1" && cd -P -- "$1"
}

function repeatUntilFail() {
  while "$@"; do :; done
}

# title: set terminal title
function title() {
  echo -en "\033]0;$1\a"
}

# Linux-specific aliases
if [[ "$(uname -s)" == "Linux" ]]
then
  alias open=xdg-open
fi

