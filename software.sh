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
  installPip
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

function installPip() {
  if [ -x "$(command -v pip3)" ]; then
    pip3 install -r $PWD/software/Pipfile
  elif [ -x "$(command -v pip)" ]; then
    pip install -r $PWD/software/Pipfile
  else
    echo "Could not find a valid Pip executable. Aborting!"
    exit 1
  fi
}


read -p "Do you want to install third-party software? Press ! if you do. " -n 1;
echo ""

if [[ $REPLY =~ ^[!]$ ]]; then
  installSoftware

else
  echo "Skipping installation of third-party software..."
fi
