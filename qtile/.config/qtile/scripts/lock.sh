#!/bin/bash

# Check if webcam is active, because then I'm probably in a video call
WEBCAM_ACTIVE=$(lsmod | grep uvcvideo | head -n 1 | awk '{ print $3 }')
if [[ "$WEBCAM_ACTIVE" -ne 0 ]]; then
  exit 1
fi

# Create a nice lock screen
rm /tmp/lockscreen.png 2> /dev/null
scrot /tmp/lockscreen.png
mogrify -scale 5% -scale 2000% /tmp/lockscreen.png

# Pause the music if it's playing
playerctl pause

# Lock the screen
i3lock --nofork -i /tmp/lockscreen.png
