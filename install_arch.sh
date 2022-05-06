#!/usr/bin/env bash

PWD="$(cd -P "$(dirname "$SOURCE")" && pwd)"

$PWD/software/install.sh arch

if ! [[ -d ~/.arco ]]; then
  mkdir ~/.arco
  mv ~/.zshrc ~/.arco/zshrc 2> /dev/null
fi

$PWD/clean.sh
stow abcde
stow bash
stow ctags
stow git
stow ideavim
stow kitty
stow linters
stow nvim
stow scripts
stow sdkman
stow starship
stow tig
stow ulauncher
stow zsh

$PWD/configure/git.sh
$PWD/configure/nvim.sh
$PWD/configure/zsh.sh
$PWD/gnome/configure.sh

