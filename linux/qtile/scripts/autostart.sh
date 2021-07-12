#!/usr/bin/env bash

SCRIPTS="$HOME/.config/qtile/scripts"

numlockx on
picom -b -f
$SCRIPTS/display.sh
$SCRIPTS/background.sh

nm-applet &
blueman-applet &
dropbox start &
xautolock -time 2 -locker "$SCRIPTS/lock.sh" &

rambox &
teams &
mailspring &
firefox &
