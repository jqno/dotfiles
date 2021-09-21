#!/bin/bash

# Check if webcam is active, because then I'm probably in a video call
WEBCAM_ACTIVE=$(lsmod | grep uvcvideo | head -n 1 | awk '{ print $3 }')
if [[ "$WEBCAM_ACTIVE" -ne 0 ]]; then
  exit 1
fi

# Pause the music if it's playing
playerctl pause

# Lock the screen
betterlockscreen --lock --show-layout 9

# Generate images for next time
betterlockscreen --update $HOME/Dropbox/wallpapers
