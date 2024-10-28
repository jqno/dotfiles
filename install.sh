#!/usr/bin/env bash

PWD="$(cd -P "$(dirname "$SOURCE")" && pwd)"


read -r -p "*** Do you want to install software? Press ! if you do. " -n 1;
echo ""

if [[ $REPLY =~ ^[!]$ ]]; then
  source "$PWD/software/install.sh"
else
  echo "** Skipping installation of third-party software..."
fi


# Stowing dotfiles
echo "*** Stowing dotfiles..."
"$PWD/clean.sh"
stow abcde
stow bash
stow btop
stow git
stow ideavim
stow kitty
stow linters
stow maven
stow mise
stow nvim
stow starship
stow tig
stow ulauncher
stow xcompose
stow zsh

mkdir -p "$HOME"/scripts
stow scripts

# Running configuration scripts
echo "*** Running configuration scripts..."
"$PWD/configure/git.sh"
"$PWD/configure/nvim.sh"
"$PWD/configure/zsh.sh"
