#!/usr/bin/env bash

LIGATURES="-> === != <= www"
NERDSYMBOLS="        "
FONTSAMPLE="3g&"
FONTCONFIG="calt:{| ss11:0xF ss14:&"
SYMBOLS="$NERDSYMBOLS     $LIGATURES     $FONTSAMPLE      $FONTCONFIG"

echo ""
echo ""
echo ""
echo -e "  Name        Nerd symbols      Ligatures            Sample   Font config (MonoLisa)"
echo -e "* Regular     $SYMBOLS"
echo -e "* \033[1mBold        $SYMBOLS\033[0m"
echo -e "* \033[3mItalic      $SYMBOLS\033[0m"
echo -e "* \033[1m\033[3mBold Italic $SYMBOLS\033[0m"
echo -e "* \033[4mUnderline   $SYMBOLS\033[0m"
echo -e "* \033[4:3mUndercurl   $SYMBOLS\033[0m"
