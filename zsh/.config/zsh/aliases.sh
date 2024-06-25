#!/usr/bin/env bash

# General
alias cd..='cd ..'

# SSH in Kitty
alias ssh='kitty +kitten ssh'

# Modern alternatives to standard tools
alias cat='bat -pp'
alias df=duf
alias du=dust
alias LS="$(which ls)"
alias ls='eza --icons'
alias tree='eza --icons --tree'
alias MAN="$(which man)"
man() {
  tldr "$1" || "$(which man)" "$1"
}

# Vim
alias vim=nvim
alias vanilla-vim='vim -u NONE -U NONE -N'

# Git
alias gitk-old='/usr/local/bin/gitk'
alias gitk='echo "Use tig!"'
alias gst='git status'
alias git='noglob git'   # So we can type `git add *Test*` instead of `git add "*Test*"`
alias pr='gh pr view --web || gh pr create --web'
alias github='gh browse'

# Java
alias setjdk='. setjdk.sh'
alias runjava=runjava.py
alias pitest='mvn clean test org.pitest:pitest-maven:mutationCoverage'
mvnd-kill() {
  pid=$(jps | grep MavenDaemon | awk '{print $1}')
  if [[ -n "$pid" ]]; then 
    kill -9 "$pid"
    echo "Killed MavenDaemon"
  fi
}

# Docker
dockerstop() {
  local matches
  matches=$(docker ps --format '{{.ID}} {{.Image}}' | grep -F "$1")

  if [ "$(echo "$matches" | wc -l)" -gt 1 ]; then
    echo "Multiple containers match the query:"
    echo "$matches" | awk '{print "- " $0}'
    return 1
  fi

  docker stop "$(echo "$matches" | awk '{print $1}')"
}

dockerstopall() {
  for container in $(docker ps -aq); do
    docker stop "$container"
    docker rm "$container"
  done
}

function dockerarmageddon {
  dockerstopall
  docker network prune -f
  docker rmi -f $(docker images --filter dangling=true -qa)
  docker volume rm $(docker volume ls --filter dangling=true -q)
  docker rmi -f $(docker images -qa)
}

# mcd
function mcd() {
  mkdir -p -- "$1" && cd -P -- "$1"
}

function repeatUntilFail() {
  while "$@"; do :; done
}

# Linux-specific aliases
if [[ "$(uname -s)" == "Linux" ]]
then
  alias open=xdg-open
fi
