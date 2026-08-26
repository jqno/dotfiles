#!/bin/bash
set -e

# Bail out if Firefox isn't installed
if ! [ -x "$(command -v firefox)" ]; then
  echo "** Firefox is not installed, skipping..."
  exit 0
fi

# Find out what the existing profile is
PROFILE_DIR="$HOME/.config/mozilla/firefox/$(awk -F= '/^\[Install/,0 { if (/^Default=/) { print $2; exit } }' ~/.config/mozilla/firefox/profiles.ini)"

# Find out where this script is
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Link the config
stow --dir="$SCRIPT_DIR" --target="$PROFILE_DIR" profile
