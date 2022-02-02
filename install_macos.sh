#!/usr/bin/env bash

PWD="$(cd -P "$(dirname "$SOURCE")" && pwd)"

$PWD/software/install.sh macos

$PWD/clean.sh
stow ctags
stow git
stow hammerspoon
stow ideavim
stow karabiner
stow kitty
stow nvim
stow python
stow scripts
stow tig
stow vim
stow yabai
stow zsh

$PWD/configure/git.sh
$PWD/configure/nvim.sh
$PWD/configure/zsh.sh

$PWD/macos/macos.sh
~/.yabairc install

