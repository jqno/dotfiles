#!/bin/bash

NUM_DISPLAYS="$(xrandr --current | grep -v disconnected | grep connected | wc -l)"

if [[ "NUM_DISPLAYS" -eq 1 ]]; then
  echo "Single display"
  xrandr \
    --output eDP1 --primary --mode 3840x2400 --pos 0x0 --scale 0.5x0.5 --rotate normal
else
  echo "Multi-monitor"
  xrandr \
    --output DP-1 --off --output DP-2 --off \
    --output eDP1 --primary --mode 3840x2400 --pos 0x0 --scale 0.5x0.5 --rotate normal \
    --output DP-3 --mode 1920x1080 --pos 1920x0 --rotate normal
fi
