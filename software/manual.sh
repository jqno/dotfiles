#!/usr/bin/env bash
# shellcheck disable=SC2164,SC1091

PWD="$(cd -P "$(dirname "$SOURCE")" && pwd)"


# Manual tools
BIN="$HOME/bin"
rm -rf "$BIN"
mkdir "$BIN"


# Fonts
echo "*** Installing fonts"
mkdir "$HOME/.fonts"
pushd "$HOME/.fonts" > /dev/null
curl -L -o fira.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip fira.zip
rm fira.zip
rm Fura*
popd > /dev/null


# SDKMAN
echo "*** Installing SDKMAN"
curl -s "https://get.sdkman.io?rcupdate=false" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"


# JDT.LS
echo "*** Installing jdt.ls"
mkdir "$BIN/jdtls"
pushd "$BIN/jdtls" > /dev/null
curl -L -o jdtls.tar.gz http://download.eclipse.org/jdtls/snapshots/jdt-language-server-latest.tar.gz
tar xf jdtls.tar.gz
rm jdtls.tar.gz
curl -L -o lombok.jar https://projectlombok.org/downloads/lombok.jar
popd > /dev/null


# Java-debug
echo "*** Installing java-debug"
pushd "$BIN" > /dev/null
git clone https://github.com/microsoft/java-debug.git
cd java-debug
./mvnw clean install -DskipTests
popd > /dev/null


# VSCode-java-test
echo "*** Installing vscode-java-test"
pushd "$BIN" > /dev/null
git clone https://github.com/microsoft/vscode-java-test.git
cd vscode-java-test
npm install
npm run build-plugin
popd > /dev/null


# Lemminx XML lanugage server
echo "*** Installing Lemminx"
pushd "$BIN" > /dev/null
LEMMINX_VERSION="0.19.2-677"
if [[ "$(uname -s)" == "Darwin" ]]; then
  LEMMINX_FILE="lemminx-osx-x86_64"
  LEMMINX_FROM="$LEMMINX_FILE"
  LEMMINX_TO="lemminx"
elif [[ "$(uname -s)" == "Linux" ]]; then
  LEMMINX_FILE="lemminx-linux"
  LEMMINX_FROM="$LEMMINX_FILE"
  LEMMINX_TO="lemminx"
else
  LEMMINX_FILE="lemminx-win32"
  LEMMINX_FROM="${LEMMINX_FILE}.exe"
  LEMMINX_TO="lemminx.exe"
fi
LEMMINX_LOCATION="https://download.jboss.org/jbosstools/vscode/snapshots/lemminx-binary/${LEMMINX_VERSION}/${LEMMINX_FILE}.zip"
curl -L -o lemminx.zip "$LEMMINX_LOCATION"
unzip lemminx.zip
mv "$LEMMINX_FROM" "$LEMMINX_TO"
rm "${LEMMINX_FILE}.zip"
popd > /dev/null


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
