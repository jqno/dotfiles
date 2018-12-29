call SetTabstop(4)
call AutocloseForProgramming()

nnoremap <buffer> <leader>bb :ElmMake<CR>
nnoremap <buffer> <leader>be :ElmErrorDetail<CR>
nnoremap <buffer> <leader>bd :ElmShowDocs<CR>
nnoremap <buffer> <leader>tt :ElmTest<CR>

augroup Elm
    autocmd!
    autocmd BufWritePre *.elm :ElmFormat
augroup END

