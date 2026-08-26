#!/usr/bin/env bash

PWD="$(cd -P "$(dirname "$SOURCE")" && pwd)"

# Fedora packages
read -r -p "*** Do you want to install Fedora packages? Press ! if you do. " -n 1
echo ""
if [[ $REPLY =~ ^[!]$ ]]; then
  echo "*** Installing Fedora packages..."
  "$PWD/software/fedora.sh"
else
  echo "** Skipping installation of Fedora packages..."
fi

# Dev software
read -r -p "*** Do you want to install dev software? Press ! if you do. " -n 1
echo ""
if [[ $REPLY =~ ^[!]$ ]]; then
  source "$PWD/software/install.sh"
else
  echo "** Skipping installation of dev software..."
fi

# Stowing dotfiles
echo "*** Stowing dotfiles..."
"$PWD/clean.sh"
stow abcde
stow bash
stow btop
stow git
stow gstreamer
stow ideavim
stow just
stow k9s
stow kitty
stow linters
stow maven
stow nvim
stow podman
stow sbt
stow starship
stow tig
stow ulauncher
stow xcompose
stow zsh

mkdir -p "$HOME"/scripts
stow scripts

# Keyd: only where there's a physical keyboard to remap, so not on SSH boxes or in containers
if compgen -G "/dev/input/by-path/*event-kbd" > /dev/null; then
  sudo mkdir -p /etc/keyd
  sudo ln -s "$PWD"/keyd/default.conf /etc/keyd/default.conf
else
  echo "** No physical keyboard found, skipping keyd configuration..."
fi

# Running configuration scripts
echo "*** Running configuration scripts..."
"$PWD/configure/git.sh"
"$PWD/configure/nvim.sh"
"$PWD/configure/zsh.sh"
"$PWD/firefox/install.sh"
