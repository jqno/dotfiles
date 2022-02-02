#!/bin/bash

wmctrl -xa "$1"
if [ "$?" -ne 0 ] && [ -n "$2" ]; then
  "$2"
fi
