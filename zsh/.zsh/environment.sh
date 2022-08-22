#!/usr/bin/env bash

# PATH
if [[ -z ${ZSH_ENV_LOADED+x} ]]; then
  ZSH_ENV_LOADED=1
  export PATH=~/bin:~/scripts:~/work-scripts:$PATH
fi

# Default editor
export EDITOR=nvim

# Required for GPG
export GPG_TTY=$(tty)

# Make sure UTF-8 is used in Vim
export LC_ALL="en_US.UTF-8"
# Help Nix find the locale info
export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive

# FZF configuration
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--bind ctrl-a:select-all"

# Don't use cowsay when using ansible
export ANSIBLE_NOCOWS=1

