function set_iterm_title() {
  echo -ne "\e]1;$1\a"
}

set_iterm_title

