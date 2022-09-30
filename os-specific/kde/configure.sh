#!/usr/bin/env sh


# krunner-symbols
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
pushd "$SCRIPT_DIR" > /dev/null

curl https://raw.githubusercontent.com/domschrei/krunner-symbols/master/install.sh | bash
stow --target "$HOME" krunner-symbols

popd > /dev/null


echo "<><><><><>"
echo "Don't forget to install these extensions:"
echo " * Bismuth"
echo "   * sudo dnf --assumeyes copr enable capucho/bismuth"
echo "   * sudo dnf --assumeyes install bismuth"
echo " * Kvantum"
echo "   * sudo dnf --assumeyes install kvantum"
echo "<><><><><>"
