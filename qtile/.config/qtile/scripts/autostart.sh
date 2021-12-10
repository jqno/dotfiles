#!/usr/bin/env bash

SCRIPTS="$HOME/.config/qtile/scripts"

function run {
  if ! pgrep $1; then
    $@ &
  fi
}

numlockx on
picom -b --experimental-backend --conf $HOME/.config/picom.conf
xplugd
$HOME/scripts/manage_keyboard.sh initialize
$HOME/scripts/manage_displays.sh
$SCRIPTS/background.sh

run redshift-gtk &
run dropbox start &
run nm-applet &
run blueberry-tray &
run volumeicon &
run pamac-tray &
run ulauncher --hide-window &
run xautolock -time 2 -locker "$SCRIPTS/lock.sh" &

# Check that we have network, and if so, start some programs
ping -c1 google.com > /dev/null 2>&1
if [[ $? -eq 0 ]]; then

  mailspring &
  firefox &
  rambox &
  teams &

fi
