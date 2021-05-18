#!/usr/bin/env bash

BIN="$HOME/bin"
rm -rf $BIN
mkdir $BIN


# Powerlevel10k
echo "** Installing Powerlevel10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $BIN/powerlevel10k


# Java toolchain
echo "** Installing Java toolchain"
curl -sL https://github.com/shyiko/jabba/raw/master/install.sh | bash -s -- --skip-rc && . ~/.jabba/jabba.sh
[ -s "$JABBA_HOME/jabba.sh" ] && source "$JABBA_HOME/jabba.sh"
jabba install adopt@1.8.0-292
jabba install adopt@1.11.0-11


# JDT.LS
echo "** Installing Eclipse JDT Language Server"
ECLIPSE_JDT_LS_SOURCE="http://download.eclipse.org/jdtls/milestones/0.70.0/jdt-language-server-0.70.0-202103051608.tar.gz"
ECLIPSE_JDT_LS_TARGET="$BIN/eclipse-jdt-ls"
mkdir $ECLIPSE_JDT_LS_TARGET
pushd $ECLIPSE_JDT_LS_TARGET > /dev/null
curl -o "archive.tar.gz" $ECLIPSE_JDT_LS_SOURCE
tar xf archive.tar.gz
rm archive.tar.gz
popd > /dev/null


# Java-debug
echo "** Installing java-debug"
pushd $BIN > /dev/null
git clone https://github.com/microsoft/java-debug.git
cd java-debug
./mvnw clean install -DskipTests
popd > /dev/null


# VSCode-java-test
echo "** Installing vscode-java-test"
pushd $BIN > /dev/null
git clone https://github.com/microsoft/vscode-java-test.git
cd vscode-java-test
npm install
npm run build-plugin
popd > /dev/null


# Coursier
echo "** Installing Coursier"
pushd $BIN > /dev/null
curl -fLo cs https://git.io/coursier-cli-"$(uname | tr LD ld)"
chmod +x cs
popd > /dev/null


# Sumneko Lua Language Server
echo "** Installing Sumneko-lua language server"
pushd $BIN > /dev/null
OSNAME="$(uname -s)"
if [[ "$OSNAME" == "Darwin" ]]; then
  PLATFORM="macos"
else
  PLATFORM="linux"
fi

git clone https://github.com/sumneko/lua-language-server
cd lua-language-server
git submodule update --init --recursive

cd 3rd/luamake
compile/install.sh
cd ../..
./3rd/luamake/luamake rebuild

if [[ "$PLATFORM" == "macos" ]]; then
  ln -s $BIN/lua-language-server/bin/OSX $BIN/lua-language-server/bin/macOS
fi

mkdir -p $HOME/.cache/nvim/nlua/sumneko_lua
ln -s $BIN/lua-language-server $HOME/.cache/nvim/nlua/sumneko_lua/lua-language-server
popd > /dev/null
