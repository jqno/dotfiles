#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SETTINGS_FILE="$SCRIPT_DIR/gnome.ini"

dconf load / < "$SETTINGS_FILE"

echo "<><><><><>"
echo "Don't forget to install these extensions:"
echo " * https://extensions.gnome.org/extension/5696/one-window-wonderland/"
echo " * https://extensions.gnome.org/extension/6057/happy-appy-hotkey/"
echo " * https://extensions.gnome.org/extension/517/caffeine/"
echo " * https://extensions.gnome.org/extension/6281/wallpaper-slideshow/"
echo " * https://extensions.gnome.org/extension/6000/quick-settings-audio-devices-renamer/"
echo " * https://extensions.gnome.org/extension/7065/tiling-shell/"
echo "<><><><><>"
