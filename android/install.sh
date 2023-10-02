#!/usr/bin/env sh

yes | pkg upgrade
yes | pkg install bat \
    clang \
    eza \
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
