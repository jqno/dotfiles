#!/usr/bin/env sh

BIN="$HOME/bin"
rm -rf $BIN
mkdir $BIN


# Java toolchain
curl -s "https://get.sdkman.io?rcupdate=false" | bash
. $HOME/.sdkman/bin/sdkman-init.sh
sdk install java 8.0.265.hs-adpt 
sdk install java 11.0.8.hs-adpt 


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


# Rust toolchain
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --profile complete
