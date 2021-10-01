#!/bin/bash


### PID-file logic to make sure that the script only runs once
### See https://youtu.be/ylohuR0fzz4?t=551 for an explanation
PIDFILE=/tmp/lock.pid
function cleanup() {
  rm "$PIDFILE"
}
if [[ -f $PIDFILE ]]; then
  pid=$(cat "$PIDFILE")
  if ps -p "$pid" > /dev/null 2>&1; then
    echo "Script is already running"
    exit 1
  else
    # process not found; overwrite
    echo $$ > "$PIDFILE"
  fi
else
  # wasn't running; write pid
  echo $$ > "$PIDFILE"
fi
trap cleanup EXIT
### End of PID-file logic


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
