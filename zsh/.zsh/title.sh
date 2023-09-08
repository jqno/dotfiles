#!/usr/bin/env bash

# title: set terminal title
function title() {
  echo -en "\033]0;$1\a"
}

precmd () {
  home_dir=$(eval echo ~)

  if [ "$PWD" = "$home_dir" ]; then
    display="~"
  else
    display="${PWD##*/}"
  fi

  title "$display"
}
