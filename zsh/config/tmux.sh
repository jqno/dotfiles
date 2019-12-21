# Start tmux (if we're not in tmux already)
if [[ -z $TMUX ]]; then
  if [[ -z $(tmux ls 2> /dev/null) ]]; then
    tmux
  else
    tmux attach
  fi
fi

