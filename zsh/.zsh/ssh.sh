#!/usr/bin/env bash

# Add all private keys to keychain
if [[ -d "$HOME/.ssh" ]]; then
  eval "$(find ~/.ssh/id_* -type f ! -name "*.*" | xargs -I {} keychain --eval {} 2> /dev/null)"
fi
