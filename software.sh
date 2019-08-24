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

  sudo xcodebuild -license accept
  if [ $? -ne 0 ]; then
    echo "Sadly, I can't continue if you don't accept the license... 😕"
    exit 1
  fi

  echo "Installing brew dependencies..."
  brew bundle install --no-upgrade --file=$PWD/software/Brewfile

  if [ $? -ne 0 ]; then
    echo "Brew failed (did you sign into the App Store?)"
    exit 1
  fi
}

function installNpm() {
  pushd $PWD/software > /dev/null
  npm install --global
  if [ $? -ne 0 ]; then
    echo "NPM failed"
    exit 1
  fi
  popd > /dev/null
}

function installGem() {
  # Built-in gem won't install globally, and brew refuses to replace its version with the built-in one: let's call it directly.
  /usr/local/opt/ruby/bin/gem install --file $PWD/software/Gemfile
  if [ $? -ne 0 ]; then
    echo "Gem failed"
    exit 1
  fi
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
  if [ $? -ne 0 ]; then
    echo "Pip failed"
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
