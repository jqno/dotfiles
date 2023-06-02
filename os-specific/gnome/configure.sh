#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SETTINGS_FILE="$SCRIPT_DIR/gnome.ini"

dconf load / < "$SETTINGS_FILE"

echo "<><><><><>"
echo "Don't forget to install these extensions:"
echo " * https://extensions.gnome.org/extension/1160/dash-to-panel/"
echo " * https://extensions.gnome.org/extension/5696/one-window-wonderland/"
echo " * https://extensions.gnome.org/extension/4684/useless-gaps/"
echo " * https://extensions.gnome.org/extension/517/caffeine/"
echo " * https://extensions.gnome.org/extension/3843/just-perfection/"
echo " * https://extensions.gnome.org/extension/4812/wallpaper-switcher/"
echo " * https://extensions.gnome.org/extension/6000/quick-settings-audio-devices-renamer/"
echo "<><><><><>"
