#!/usr/bin/env bash

echo "*** Some dependencies need the administrator password:"
sudo -v

echo "*** Installing dependencies..."


# Terminal
sudo dnf --assumeyes install kitty


# System tools
sudo yum --assumeyes groupinstall 'Development Tools'
sudo dnf --assumeyes install gcc-g++
sudo dnf --assumeyes install libxcrypt-compat
sudo dnf --assumeyes install procps-ng
sudo dnf --assumeyes install tlp
sudo dnf --assumeyes install tlp-rdw


# Fonts
sudo dnf --assumeyes install fontawesome5-fonts-all
sudo dnf --assumeyes install unifont-fonts


# KDE
sudo dnf --assumeyes copr enable capucho/bismuth 
sudo dnf --assumeyes install bismuth
