#!/usr/bin/env bash

# PATH
if [[ -z ${ZSH_ENV_LOADED+x} ]]; then
  ZSH_ENV_LOADED=1
  
  if [[ "$(uname -s)" == "Darwin" ]]; then
    GEMDIR=`gem env gemdir`/bin
    export PATH=~/Library/Application\ Support/Coursier/bin:~/Library/Python/3.7/bin:/usr/local/opt/ruby/bin:$GEMDIR:$PATH
  elif [[ "$(uname -s)" == "Linux" ]]; then
    export PATH=~/.local/bin:~/.npm-global/bin:~/.local/share/coursier/bin:$PATH
  fi
  export PATH=/usr/local/sbin:/sbin:~/bin:~/scripts:~/.npm-global:~/.cargo/bin:$PATH
fi

# Default editor
export EDITOR=vim

# Required for GPG
export GPG_TTY=$(tty)

# Make sure UTF-8 is used in Vim
export LC_ALL="en_US.UTF-8"

# FZF configuration
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--bind ctrl-a:select-all"

# Initialize JAVA_HOME for use in `.zprofile` where `setjdk` is not available
if [[ "$(uname -s)" == "Darwin" ]]; then
  export JABBA_HOME="/Users/jqno/.jabba"
elif [[ "$(uname -s)" == "Linux" ]]; then
  export JABBA_HOME="/home/jqno/.jabba"
fi
export JAVA_HOME="$JABBA_HOME/jdk/adopt@1.11.0-11"

