#!/usr/bin/env bash
# Adapted from https://github.com/ldziedziul/j, for use with SDKMAN.io

# Must be loaded as an alias to run in the current shell, otherwise the `sdk` alias is not available:
# alias setjdk=". setjdk.sh"

function print_usage() {
    CANDIDATES=$(/bin/ls "$SDKMAN_DIR"/candidates/java | grep -v current)
    PLAIN=$(echo "$CANDIDATES" | grep -v graal | awk -F'.' '{print $1}')
    GRAAL=$(echo "$CANDIDATES" | grep graal | sed -E 's/-([^-]*)$/ (\1)/')
    VERSIONS=$(printf '%s\n%s\n' "$PLAIN" "$GRAAL" | grep . | sort -nr | uniq)
    CURRENT=$(basename "$(readlink "$JAVA_HOME" || echo "$JAVA_HOME")" | awk -F'.' '{print $1}')
    echo "Available JDK versions: "
    echo "$VERSIONS"
    echo
    echo "Current:"
    echo "$CURRENT"
    echo
    echo "Usage: setjdk <java_version>"
}

if [[ $# -eq 1 ]]; then
  VERSION_NUMBER=$1
  CANDIDATES=$(/bin/ls "$SDKMAN_DIR"/candidates/java | grep -v current | grep "^$VERSION_NUMBER." | sort -r)
  IDENTIFIER=$(echo "$CANDIDATES" | grep -v graal | head -n 1)
  if [[ -z $IDENTIFIER ]]; then
    IDENTIFIER=$(echo "$CANDIDATES" | head -n 1)
  fi
  if [[ -z $IDENTIFIER ]]; then
    echo "No valid JDK found for version [$VERSION_NUMBER]"
  else
    echo "Switching JDK to $IDENTIFIER"
    sdk use java "$IDENTIFIER"
  fi
else
  print_usage
fi
