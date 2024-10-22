export EDITOR=nvim

# Aliases for when in Vim terminal
if [ -n "$VIM_TERMINAL" ]
then
  export TERM=xterm-256color
  alias :q='exit'
  alias :q!='exit'
  alias vim='echo "Je zit al in vim!" && false'
fi
