#!/usr/bin/env bash

# Setting up .zprofile
PWD="$(cd -P "$(dirname "$SOURCE")" && pwd)"
ln -s $PWD/zsh/.zsh/environment.sh ~/.zprofile

# Make zsh the default shell
LOCATION="$(which zsh)"

echo "** Changing shell to:"
echo $LOCATION | sudo tee -a /etc/shells
chsh -s $LOCATION

