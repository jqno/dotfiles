#!/usr/bin/env bash

PWD="$(cd -P "$(dirname "$SOURCE")" && pwd)"


# Install Homebrew
if ! [ -x "$(command -v brew)" ]; then
  echo "*** Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi


# Install software
echo "*** Installing software via Homebrew..."
brew bundle install --no-upgrade --file="$PWD/software/Brewfile"


# Install manual software
echo "*** Installing software from other package managers..."
"$PWD/software/nonbrew.sh"


# Install manual software
echo "*** Installing manual software..."
"$PWD/software/manual.sh"
