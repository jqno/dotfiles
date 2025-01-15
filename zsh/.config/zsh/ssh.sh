if [[ -z "$XDG_CURRENT_DESKTOP" ]]; then
  # Start the SSH agent to remember the SSH passphrase, but only if we're not inside Gnome which does this automatically
  export SSH_AGENT_TIMEOUT=7200 # Forget the passphrase after 2 hours
  eval "$(ssh-agent -s)" > /dev/null
fi
