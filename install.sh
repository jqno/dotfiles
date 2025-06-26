#!/usr/bin/env bash

PWD="$(cd -P "$(dirname "$SOURCE")" && pwd)"

# Dev software
read -r -p "*** Do you want to install dev software? Press ! if you do. " -n 1;
echo ""
if [[ $REPLY =~ ^[!]$ ]]; then
  source "$PWD/software/install.sh"
else
  echo "** Skipping installation of dev software..."
fi

# Desktop software
read -r -p "*** Do you want to install desktop software? Press $ if you do. " -n 1;
echo ""
if [[ $REPLY =~ ^[$]$ ]]; then
  source "$PWD/software/desktop.sh"
else
  echo "** Skipping installation of desktop software..."
fi

# Stowing dotfiles
echo "*** Stowing dotfiles..."
"$PWD/clean.sh"
stow abcde
stow aider
stow bash
stow btop
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
stow xcompose
stow zsh

mkdir -p "$HOME"/scripts
stow scripts

sudo mkdir -p /etc/keyd
sudo ln -s "$PWD"/keyd/default.conf /etc/keyd/default.conf

# Running configuration scripts
echo "*** Running configuration scripts..."
"$PWD/configure/git.sh"
"$PWD/configure/nvim.sh"
"$PWD/configure/zsh.sh"
