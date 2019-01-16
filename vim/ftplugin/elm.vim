call SetTabstop(4)
call AutocloseForProgramming()

nnoremap <buffer> <leader>mb :ElmMake<CR>
nnoremap <buffer> <leader>me :ElmErrorDetail<CR>
nnoremap <buffer> <leader>md :ElmShowDocs<CR>
nnoremap <buffer> <leader>tt :ElmTest<CR>

augroup Elm
    autocmd!
    autocmd BufWritePre *.elm :ElmFormat
augroup END

