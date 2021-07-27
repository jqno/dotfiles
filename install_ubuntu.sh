#!/usr/bin/env bash

PWD="$(cd -P "$(dirname "$SOURCE")" && pwd)"

$PWD/software/install.sh ubuntu

$PWD/clean.sh
stow abcde
stow ctags
stow git
stow ideavim
stow kitty
stow nvim
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

sudo cat $PWD/qtile/.config/qtile/add-to-sudoers | sudo EDITOR='tee -a' visudo

