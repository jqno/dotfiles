compiler maven
setlocal formatprg=scalafmt\ --stdin\ 2>/dev/null

nnoremap <buffer><leader>gs :CocCommand metals.go-to-super-method<CR>
nnoremap <buffer><leader>gS :CocCommand metals.super-method-hierarchy<CR>

command! -buffer Worksheet Mkdir! .vim<bar>sp .vim/metals.worksheet.sc

