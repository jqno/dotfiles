compiler maven
setlocal formatprg=scalafmt\ --stdin\ 2>/dev/null

command! -buffer Worksheet Mkdir! .vim<bar>sp .vim/metals.worksheet.sc

