#!/usr/bin/env bash

SYMBOLS="-> === www zero:0 ss02:<= ss03:& ss04:\$ ss07:!~ cv14:3 ss10:fl 😃"

kitty +list-fonts --psnames

echo -e "Regular     $SYMBOLS"
echo -e "\033[1mBold        $SYMBOLS\033[0m"
echo -e "\033[3mItalic      $SYMBOLS\033[0m"
echo -e "\033[1m\033[3mBold Italic $SYMBOLS\033[0m"
