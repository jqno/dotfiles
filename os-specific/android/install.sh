#!/usr/bin/env sh

apt upgrade
pkg install bat \
    clang \
    ctags \
    exa \
    fd \
    fzf \
    keychain \
    man \
    maven \
    neovim \
    nodejs \
    openjdk-17 \
    restic \
    ripgrep \
    starship \
    stow \
    tig \
    vale \
    zsh \
    zsh-completions


chsh -s zsh
