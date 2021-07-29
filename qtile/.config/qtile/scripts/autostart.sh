#!/usr/bin/env bash

SCRIPTS="$HOME/.config/qtile/scripts"

numlockx on
picom -b -f
$SCRIPTS/display.sh
$SCRIPTS/background.sh

dropbox start &
xautolock -time 2 -locker "$SCRIPTS/lock.sh" &

# Check that we have network, and if so, start some programs
ping -c1 google.com > /dev/null 2>&1
if [[ $? -eq 0 ]]; then

  rambox &
  teams &
  mailspring &
  firefox &

fi
