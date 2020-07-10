compiler maven
setlocal formatprg=scalafmt\ --stdin\ 2>/dev/null

nnoremap <leader>ro :update<CR>:silent !scala-organize-imports.sh %<CR>:redraw!<CR>

