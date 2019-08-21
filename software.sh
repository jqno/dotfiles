#!/usr/bin/env sh

PWD="$(cd -P "$(dirname "$SOURCE")" && pwd)"

function installSoftware() {
  if [ "$(uname -s)" == "Darwin" ]; then
    installMacos
  else
    echo "Not running on a supported OS! Can't install software! Abort abort!"
    exit 1
  fi

  installNpm
  installGem
}

function installMacos() {
  if ! [ -x "$(command -v brew)" ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  echo "Installing brew dependencies..."
  brew bundle install --no-upgrade --file=$PWD/software/Brewfile
}

function installNpm() {
  pushd $PWD/software > /dev/null
  npm install --global
  popd > /dev/null
}

function installGem() {
  gem install bundler
  bundle install --gemfile=$PWD/software/Gemfile
}


read -p "Do you want to install third-party software? Press ! if you do. " -n 1;
echo ""

if [[ $REPLY =~ ^[!]$ ]]; then
  installSoftware

else
  echo "Skipping installation of third-party software..."
fi
