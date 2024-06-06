function load {
  [[ -f "$1" ]] && source "$1"
}

# Load configuration
h=$HOME/.config/zsh
load $h/vim.sh
load $h/settings.zsh
load $h/history.zsh
load $h/dependencies.zsh
load $h/functions.sh
load $h/environment.sh
load $h/aliases.sh
load $h/hotkeys.sh

# Load config from private/work dotfiles
for dir in "$HOME"/env/*; do
  if [[ -d "$dir" ]]; then
    load "$dir"/env.sh
  fi
done

