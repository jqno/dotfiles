# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Custom scripts
source ~/.zsh/init.zsh
source ~/.zsh/functions.sh
source ~/.zsh/environment.sh
source ~/.zsh/aliases.sh
source ~/.zsh/hotkeys.sh
source ~/.zsh/completion.zsh
source ~/.zsh/fzf.zsh
source ~/.zsh/vim-terminal-mode.sh
source ~/.zsh/ssh.sh
source ~/.env/session.sh

# Zsh plugins
if [[ "$(uname -s)" == "Darwin" ]]; then
  source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ "$(uname -s)" == "Linux" ]]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=7'

eval "$(starship init zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
