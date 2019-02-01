call SetTabstop(4)
call AutocloseForProgramming()

setlocal wildignore=node_modules/*,elm.js

augroup Elm
    autocmd!
    autocmd BufWritePre *.elm :ElmFormat
augroup END

