#!/usr/bin/env bash

# General
alias cd..='cd ..'

# Modern alternatives to standard tools
alias cat='bat -pp'
alias df=duf
alias du=dust
alias ls='exa --icons'
alias man-orig="$(which man)"
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
alias mvn-orig="$(which mvn)"
alias mvn='mvnd -C'
alias runjava=runjava.py
alias pitest='mvn clean test org.pitest:pitest-maven:mutationCoverage'

# mcd
function mcd() {
  mkdir -p -- "$1" && cd -P -- "$1"
}

# title: set terminal title
function title() {
  echo -en "\033]0;$1\a"
}

# MacOS pre-installs a bad version of ctags so we substitute our own.
if [[ "$(uname -s)" == "Darwin" ]]
then
  alias ctags="`brew --prefix`/bin/ctags"
fi

# Linux-specific aliases
if [[ "$(uname -s)" == "Linux" ]]
then
  alias open=xdg-open
fi

