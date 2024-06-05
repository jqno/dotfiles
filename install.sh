#!/usr/bin/env bash

PWD="$(cd -P "$(dirname "$SOURCE")" && pwd)"


read -r -p "*** Do you want to install software? Press ! if you do. " -n 1;
echo ""

if [[ $REPLY =~ ^[!]$ ]]; then
  echo "*** DEVELOPER TOOLS"
  echo "Make sure you have installed the developer tools!"
  echo "* On macOS: type \`git\` and follow the instructions."
  echo "* On Linux: run \`software/fedora.sh\`"
  read -r -p "*** Ready? Press ! to continue or anything else to abort. " -n 1;
  echo ""

  if [[ $REPLY =~ ^[^!]$ ]]; then
    exit 1
  fi

  source "$PWD/software/install.sh"

else
  echo "** Skipping installation of third-party software..."
fi


# Stowing dotfiles
echo "*** Stowing dotfiles..."
"$PWD/clean.sh"
stow abcde
stow bash
stow git
stow ideavim
stow kitty
stow linters
stow maven
stow nvim
stow sdkman
stow starship
stow tig
stow ulauncher
stow wezterm
stow zsh

mkdir -p "$HOME"/scripts
stow scripts

# Running configuration scripts
echo "*** Running configuration scripts..."
"$PWD/configure/git.sh"
"$PWD/configure/nvim.sh"
"$PWD/configure/zsh.sh"
