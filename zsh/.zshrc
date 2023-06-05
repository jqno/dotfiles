# OS-specific
[[ -e /etc/zshrc ]] && source /etc/zshrc

# Homebrew
if [ -x "$(command -v brew)" ]; then
  eval "$(brew shellenv)"
elif [[ -d /home/linuxbrew/.linuxbrew ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Custom scripts
source ~/.zsh/init.zsh
source ~/.zsh/functions.sh
source ~/.zsh/environment.sh
source ~/.zsh/aliases.sh
source ~/.zsh/hotkeys.sh
source ~/.zsh/completion.zsh
source ~/.zsh/vim-terminal-mode.sh
source ~/.zsh/ssh.sh
source ~/.zsh/title.sh

function load {
  [[ -f "$1" ]] && source "$1"
}

# Zsh plugins
load $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
load $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=7'

# FZF plugins
load $HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh
load $HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh
load /data/data/com.termux/files/usr/share/fzf/completion.zsh
load /data/data/com.termux/files/usr/share/fzf/key-bindings.zsh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Starship prompt
eval "$(starship init zsh)"

load ~/work-scripts/aliases.sh
load ~/dots-private/aliases.sh
