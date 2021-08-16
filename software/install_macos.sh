#!/usr/bin/env bash

PWD="$(cd -P "$(dirname "$SOURCE")" && pwd)"

echo "** Some dependencies need the administrator password:"
sudo -v

if ! [ -x "$(command -v brew)" ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

echo "** Installing mas and Xcode. This may take a while; the Launchpad icon has a nice progress bar."
brew bundle install --no-upgrade --file=$PWD/software/macos/Brewfile-pre
if [ $? -ne 0 ]; then
  echo "** Unable to install Xcode: aborting."
  exit 1
fi

sudo xcodebuild -license accept
if [ $? -ne 0 ]; then
  echo "** Sadly, I can't continue if you don't accept the license... 😕"
  exit 1
fi

echo "** Installing brew dependencies..."
brew bundle install --no-upgrade --file=$PWD/software/macos/Brewfile

if [ $? -ne 0 ]; then
  echo "** Brew failed (did you sign into the App Store?)"
  exit 1
fi

$PWD/software/macos/install_general.sh

