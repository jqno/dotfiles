scriptencoding utf-8

function! s:RunJavaProgram() abort
    let l:pattern='^package \zs[A-Za-z.]*\ze;\?$'
    normal! m`
    let l:line=search(l:pattern)
    normal! ``
    let l:package=matchstr(getline(l:line), l:pattern)
    let l:class=expand('%:t:r')
    let l:fqn = l:package . '.' . l:class

    if matchstr(l:class, 'Test$') ==# ''
        exec 'Dispatch run-java.sh -r org.junit.runner.JUnitCore ' . l:fqn
    else
        if &filetype ==# 'scala'
            let l:fqn .= '$delayedInit$body'
        elseif &filetype ==# 'kotlin'
            let l:fqn .= 'Kt'
        endif
        exec 'Dispatch run-java.sh -r ' . l:fqn
    endif
endfunction

function! s:GenerateJavaClasspath() abort
    exec 'Dispatch! run-java.sh -cp'
endfunction

function! s:CreateMappings() abort
    nnoremap <buffer><silent> <leader>mc :call <SID>GenerateJavaClasspath()<CR>
    nnoremap <buffer><silent> <leader>mr :call <SID>RunJavaProgram()<CR>
    nnoremap <buffer><silent> <F5> :call <SID>RunJavaProgram()<CR>
endfunction

augroup RunJava
    autocmd!
    autocmd FileType java,scala,kotlin call <SID>CreateMappings()
augroup END

