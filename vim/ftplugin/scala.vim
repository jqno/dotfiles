compiler maven
setlocal formatprg=scalafmt\ --stdin\ 2>/dev/null

nnoremap <buffer><leader>ro :update<CR>:silent !scala-organize-imports.sh %<CR>:redraw!<CR>

