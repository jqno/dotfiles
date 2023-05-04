#!/usr/bin/env sh

precmd () {
  home_dir=$(eval echo ~)

  if [ "$PWD" = "$home_dir" ]; then
    display="~"
  else
    display="${PWD##*/}"
  fi

  title "$display"
}
