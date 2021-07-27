zstyle :compinstall filename '/Users/jqno/.zshrc'
autoload -Uz compinit
compinit

# Case-insensitive completions
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# Highlight the currently selected option
zstyle ':completion:*' menu select

