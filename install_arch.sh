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
stow nvim
stow picom
stow python
stow qtile
stow scripts
stow tig
stow vim
stow Xmodmap
stow zsh

$PWD/configure/git.sh
$PWD/configure/nvim.sh
$PWD/configure/vim.sh
$PWD/configure/zsh.sh

sudo bash -c "cat $PWD/qtile/.config/qtile/add-to-sudoers >> /etc/sudoers"
