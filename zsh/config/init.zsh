# PATH
export PATH=$PATH:~/scripts

# Settings
setopt autocd nomatch
unsetopt beep extendedglob notify

# The delete button doesn't work unless we bind it to `delete-char`
bindkey "^[[3~" delete-char
bindkey -M vicmd "^[[3~" delete-char

# History
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt hist_expire_dups_first
setopt appendhistory

# Colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export CLICOLOR=1
autoload colors; colors;

# VIM mode
bindkey -v
export KEYTIMEOUT=1
export EDITOR=vim

