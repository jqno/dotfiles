#!/usr/bin/env bash

PWD="$(cd -P "$(dirname "$SOURCE")" && pwd)"

$PWD/software/install.sh arch

if ! [[ -d ~/.arco ]]; then
  mkdir ~/.arco
  mv ~/.config/qtile ~/.arco/qtile 2> /dev/null
  mv ~/.zshrc ~/.arco/zshrc 2> /dev/null
fi

$PWD/clean.sh
stow abcde
stow ctags
stow git
stow ideavim
stow kitty
stow linters
stow nvim
stow picom
stow qtile
stow redshift
stow scripts
stow tig
stow ulauncher
stow x
stow zsh

$PWD/configure/git.sh
$PWD/configure/nvim.sh
$PWD/configure/zsh.sh
$PWD/gnome/configure.sh

sudo bash -c "cat $PWD/qtile/.config/qtile/add-to-sudoers >> /etc/sudoers"

