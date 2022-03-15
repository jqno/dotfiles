#!/usr/bin/env sh

WINDOWS=$(wmctrl -l | cut -f1 -d" ")
for win in $WINDOWS; do
  wmctrl -ir $win -b add,maximized_vert,maximized_horz
done
