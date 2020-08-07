scriptencoding utf-8

function! s:RunJavaProgram() abort
    exec 'Dispatch runjava.py ' . expand('%')
endfunction

function! s:CreateMappings() abort
    nnoremap <buffer><silent> <leader>mr :call <SID>RunJavaProgram()<CR>
    nnoremap <buffer><silent> <F5> :call <SID>RunJavaProgram()<CR>
endfunction

augroup RunJava
    autocmd!
    autocmd FileType java,scala,kotlin call <SID>CreateMappings()
augroup END

