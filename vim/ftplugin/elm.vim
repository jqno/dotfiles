call SetTabstop(4)
call AutocloseForProgramming()

augroup Elm
    autocmd!
    autocmd BufWritePre *.elm :ElmFormat
augroup END

