#!/usr/bin/env sh

apt upgrade
pkg install clang \
    exa \
    fd \
    fzf \
    lua-language-server \
    man \
    neovim \
    ripgrep \
    starship \
    stow \
    vale \
    zsh \
    zsh-completions


chsh -s zsh
