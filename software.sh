#!/usr/bin/env sh

PWD="$(cd -P "$(dirname "$SOURCE")" && pwd)"

function installSoftware() {
  echo "** Some dependencies need the administrator password:"
  sudo -v

  if [ "$(uname -s)" == "Darwin" ]; then
    installMacos
  else
    echo "** Not running on a supported OS! Can't install software! Abort abort!"
    exit 1
  fi

  installNpm
  installGem
  installPip
  installManual
}

function installMacos() {
  if ! [ -x "$(command -v brew)" ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  echo "** Installing mas and Xcode. This may take a while; the Launchpad icon has a nice progress bar."
  brew bundle install --no-upgrade --file=$PWD/software/Brewfile-pre
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
  brew bundle install --no-upgrade --file=$PWD/software/Brewfile

  if [ $? -ne 0 ]; then
    echo "** Brew failed (did you sign into the App Store?)"
    exit 1
  fi
}

function installNpm() {
  echo "** Installing npm dependencies..."
  source $PWD/software/npm.sh
  if [ $? -ne 0 ]; then
    echo "** npm failed"
    exit 1
  fi
}

function installGem() {
  echo "** Installing Gem dependencies..."
  source $PWD/software/gem.sh
  if [ $? -ne 0 ]; then
    echo "** Gem failed"
    exit 1
  fi
}

function installPip() {
  echo "** Installing Pip dependencies..."
  source $PWD/software/pip.sh
  if [ $? -ne 0 ]; then
    echo "** Pip failed"
    exit 1
  fi
}

function installManual() {
  echo "** Installing manual dependencies..."
  source $PWD/software/manual.sh
  if [ $? -ne 0 ]; then
    echo "** Manual failed"
    exit 1
  fi
}


read -p "** Do you want to install third-party software? Press ! if you do. " -n 1;
echo ""

if [[ $REPLY =~ ^[!]$ ]]; then
  installSoftware

else
  echo "** Skipping installation of third-party software..."
fi
