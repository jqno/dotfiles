# PATH
export PATH=$PATH:~/scripts

# Settings
# See for meanings: https://linux.die.net/man/1/zshoptions
setopt autocd nomatch
setopt auto_menu complete_in_word always_to_end
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
autoload -U colors && colors

# VIM mode
bindkey -v
export KEYTIMEOUT=1
export EDITOR=vim

