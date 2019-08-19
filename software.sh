#!/usr/bin/env sh

PWD="$(cd -P "$(dirname "$SOURCE")" && pwd)"

function installSoftware() {
  installMacos
}

function installMacos() {
  if ! [ -x "$(command -v brew)" ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  echo "Installing brew dependencies..."
  brew bundle install --no-upgrade --file=$PWD/software/Brewfile
}


read -p "Do you want to install third-party software? Press ! if you do. " -n 1;
echo ""

if [[ $REPLY =~ ^[!]$ ]]; then
  installSoftware

else
  echo "Skipping installation of third-party software..."
fi
