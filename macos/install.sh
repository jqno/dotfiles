#!/usr/bin/env bash

if [ "$(uname -s)" == "Darwin" ]; then
  read -p "Do you want to install software through Homebrew? Press ! if you do. " -n 1;
  echo ""

  if [[ $REPLY =~ ^[!]$ ]]; then
    if ! [ -x "$(command -v brew)" ]; then
      /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    PWD="$(cd -P "$(dirname "$SOURCE")" && pwd)"

    echo "Installing brew dependencies..."
    brew bundle install --no-upgrade --file=$PWD/macos/Brewfile

  else
    echo "Skipping Homebrew..."
  fi
fi

