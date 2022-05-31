#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
pushd "$SCRIPT_DIR" > /dev/null

echo "*** Installing macOS specific dependencies..."
brew bundle install --no-upgrade --file=Brewfile

if [ $? -ne 0 ]; then
  echo "** Brew failed (did you sign into the App Store?)"
  exit 1
fi

./settings.sh

stow --target "$HOME" hammerspoon
stow --target "$HOME" karabiner
stow --target "$HOME" yabai
~/.yabairc install

popd > /dev/null
