#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 file1 file2"
  exit 1
fi

nvim -c "edit $1" -c "vsp $2" -c "windo diffthis"
