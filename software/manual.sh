#!/usr/bin/env bash
# shellcheck disable=SC2164,SC1091

PWD="$(cd -P "$(dirname "$SOURCE")" && pwd)"


# Manual tools
BIN="$HOME/bin"
rm -rf "$BIN"
mkdir "$BIN"


# SDKMan
echo "*** Installing SDKMAN"
curl -s "https://get.sdkman.io?rcupdate=false" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

sdk install kotlin
sdk install kscript


# Coursier
coursier install scalafix


# Vale Alex and Proselint styles
echo "*** Installing some styles for Vale linter"
rm -rf ~/.vale
mkdir -p ~/.vale/sources
pushd ~/.vale > /dev/null

git clone https://github.com/errata-ai/alex sources/alex
ln -s sources/alex/alex alex
git clone https://github.com/errata-ai/proselint sources/proselint
ln -s sources/proselint/proselint proselint
rm proselint/Annotations.yml # Let's allow words like NOTE, TODO and FIXME

popd > /dev/null


# Keyd
rm -rf ~/.keyd
mkdir ~/.keyd
pushd ~/.keyd > /dev/null

git clone https://github.com/rvaiya/keyd
cd keyd
make && sudo make install
sudo systemctl enable --now keyd

popd > /dev/null
rm -rf ~/.keyd

echo "***"
echo "Don't forget to create a /etc/libinput/local-overrides.quirks -- it really works!"
echo "https://github.com/rvaiya/keyd?tab=readme-ov-file#why-is-my-trackpad-is-interfering-with-input-after-enabling-keyd"
echo "***"
read -r -p "*** Press a key when you've read this " -n 1
