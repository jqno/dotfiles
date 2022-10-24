#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SETTINGS_FILE="$SCRIPT_DIR/gnome.ini"

dconf load / < "$SETTINGS_FILE"

echo "<><><><><>"
echo "Don't forget to install these extensions:"
echo " * https://extensions.gnome.org/extension/307/dash-to-dock/"
echo " * https://extensions.gnome.org/extension/2890/tray-icons-reloaded/"
echo " * https://extensions.gnome.org/extension/517/caffeine/"
echo " * https://extensions.gnome.org/extension/906/sound-output-device-chooser/"
echo " * https://extensions.gnome.org/extension/3843/just-perfection/"
echo " * https://extensions.gnome.org/extension/3960/transparent-top-bar-adjustable-transparency/"
echo " * https://extensions.gnome.org/extension/4812/wallpaper-switcher/"
echo "And perhaps:"
echo " * https://extensions.gnome.org/extension/4684/useless-gaps/"
echo "Also, manually install:"
echo " * https://github.com/aXe1/gnome-shell-extension-maximized-by-default/issues/10"
echo "<><><><><>"
