#!/bin/bash

PARAM=$1

NUM_DISPLAYS="$(xrandr --query | grep -v disconnected | grep -c connected)"

LAPTOP_DISPLAY="eDP1"
LAPTOP_RESOLUTION="1920x1200"
OTHER_DISPLAY="DP3"

if [[ "NUM_DISPLAYS" -eq 1 ]]; then
  echo "Single display"
  xrandr \
    --output eDP1 --primary --mode 3840x2400 --pos 0x0 --scale 0.5x0.5 --rotate normal
else
  echo "Multi-monitor"
  if [[ -z "$PARAM" || "$PARAM" = "right" ]]; then

    xrandr \
      --output $LAPTOP_DISPLAY --primary --mode $LAPTOP_RESOLUTION --scale 1x1 --rotate normal \
      --output $OTHER_DISPLAY --auto --right-of eDP1 --rotate normal

  elif [[ "$PARAM" = "left" ]]; then

    xrandr \
      --output $LAPTOP_DISPLAY --primary --mode $LAPTOP_RESOLUTION --scale 1x1 --rotate normal \
      --output $OTHER_DISPLAY --auto --left-of eDP1 --rotate normal

  elif [[ "$PARAM" = "mirror" ]]; then

    res_external=$(xrandr --query | sed -n "/^$OTHER_DISPLAY/,/\+/p" | \
        tail -n 1 | awk '{print $1}')
    res_internal=$(xrandr --query | sed -n "/^$LAPTOP_DISPLAY/,/\+/p" | \
        tail -n 1 | awk '{print $1}')

    res_ext_x=$(echo "$res_external" | sed 's/x.*//')
    res_ext_y=$(echo "$res_external" | sed 's/.*x//')
    res_int_x=$(echo "$res_internal" | sed 's/x.*//')
    res_int_y=$(echo "$res_internal" | sed 's/.*x//')

    scale_x=$(echo "$res_ext_x / $res_int_x" | bc -l)
    scale_y=$(echo "$res_ext_y / $res_int_y" | bc -l)

    echo "Mirroring at $res_external"

    xrandr --output "$OTHER_DISPLAY" --auto --scale 1.0x1.0 \
        --output "$LAPTOP_DISPLAY" --auto --same-as "$OTHER_DISPLAY" \
        --scale "$scale_x"x"$scale_y"
  fi
fi
