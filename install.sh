#!/usr/bin/env bash

PWD="$(cd -P "$(dirname "$SOURCE")" && pwd)"
OSNAME="$(uname -s)"

function installDotfiles() {
  echo "*************************"
  echo "** INSTALLING SOFTWARE **"
  echo "*************************"
  . $PWD/software.sh

  echo "******************************"
  echo "** INSTALLING CONFIGURATION **"
  echo "******************************"
  installFor "ctags.d"
  installFor "fzf.zsh"
  scriptFor "git"
  installFor "gitignore" ".config/git/ignore" ".config/git"
  installFor "ideavimrc"
  installFor "kitty" ".config/kitty" ".config"
  installFor "scripts" "scripts"
  installFor "tigrc"
  installFor "vim"
  scriptFor "vim"
  installFor "zsh/zshrc" ".zshrc"
  installFor "zsh/config" ".zsh"
  installFor "zsh/config/environment.sh" ".zprofile" # Makes sure environment variables are loaded in MacVim as well
  scriptFor "zsh"

  # Python linting
  installFor "flake8"
  installFor "pylintrc"

  # OS-dependent
  if [ "$OSNAME" == "Darwin" ]; then
    scriptFor "macos/macos"
    installFor "macos/hammerspoon" ".hammerspoon"
    installFor "macos/karabiner.json" ".config/karabiner/karabiner.json" ".config/karabiner"
    installFor "macos/yabairc" ".yabairc"

    # .yabairc needs to be executed as a script
    ~/.yabairc install
  fi
}


## $1 = FROM
## $2 = TO
## $3 = IN
function installFor() {
  FROM=$1
  if [ "$2" == "" ]; then
    TO=".$FROM"
  else
    TO=$2
  fi

  if [ "$3" != "" ]; then
    mkdir -p ~/$3
  fi

  echo "** Linking $FROM to ~/$TO..."
  rm ~/$TO 2> /dev/null
  ln -s $PWD/$FROM ~/$TO
}

function scriptFor() {
  echo "** Installing $1..."
  . $PWD/$1.sh
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  installDotfiles
else
  read -p "** This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    installDotfiles
  fi
fi
