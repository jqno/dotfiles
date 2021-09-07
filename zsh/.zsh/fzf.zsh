#/usr/local/opt/fzf/shell/completion.zsh
if [[ "$(uname -s)" == "Darwin" ]]; then
  source /usr/local/opt/fzf/shell/completion.zsh
  source /usr/local/opt/fzf/shell/key-bindings.zsh
elif [[ "$(uname -s)" == "Linux" ]]; then
  source /usr/share/fzf/completion.zsh
  source /usr/share/fzf/key-bindings.zsh
fi
