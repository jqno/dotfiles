#!/usr/bin/env bash

# Make zsh the default shell

LOCATION=""
if [[ "$(uname -s)" == "Darwin" ]]; then
  LOCATION="/usr/local/bin/zsh"
elif [[ "$(uname -s)" == "Linux" ]]; then
  LOCATION="/usr/bin/zsh"
else
  echo "Don't know the location of zsh on this system: $(uname -s)"
  exit 1
fi

echo "** Changing shell to:"
echo $LOCATION | sudo tee -a /etc/shells
chsh -s $LOCATION

