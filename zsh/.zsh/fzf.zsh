#/usr/local/opt/fzf/shell/completion.zsh
if [[ "$(uname -s)" == "Darwin" ]]; then
  source /usr/local/opt/fzf/shell/completion.zsh
  source /usr/local/opt/fzf/shell/key-bindings.zsh
elif [[ "$(uname -s)" == "Linux" ]]; then
  source /usr/share/doc/fzf/examples/completion.zsh
  source /usr/share/doc/fzf/examples/key-bindings.zsh
fi
