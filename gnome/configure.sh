#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SETTINGS_FILE="$SCRIPT_DIR/gnome.ini"

dconf load / < "$SETTINGS_FILE"

echo "<><><><><>"
echo "Don't forget to install these extensions:"
echo " * https://extensions.gnome.org/extension/3357/material-shell/"
echo " * https://extensions.gnome.org/extension/517/caffeine/"
echo " * https://extensions.gnome.org/extension/906/sound-output-device-chooser/"
echo "<><><><><>"
