#!/usr/bin/env bash
# Adapted from https://github.com/ldziedziul/j, for use with SDKMAN.io

# Must be loaded as an alias to run in the current shell, otherwise the `sdk` alias is not available:
# alias setjdk=". setjdk.sh"

function print_usage() {
    echo "Available versions: "
    jabba ls
    echo
    echo "Current:"
    jabba current
    echo
    echo "Usage: setjdk <java_version>"
}

if [[ $# -eq 1 ]]; then
  VERSION_NUMBER=$1
  IDENTIFIER=$(jabba ls | grep "@1.$VERSION_NUMBER" | sort -r | head -n 1)
  if [[ -z $IDENTIFIER ]]; then
    echo "No valid JDK found for version [$VERSION_NUMBER]"
  else
    echo "Switching to $IDENTIFIER"
    jabba use $IDENTIFIER
  fi
else
  print_usage
fi
