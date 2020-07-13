compiler maven
call SetTabstop(4)


" *** Running
function! s:RunJavaProgram() abort
    let l:pattern='^package \zs.*\ze;$'
    normal! m`
    let l:line=search(l:pattern)
    normal! ``
    let l:package=matchstr(getline(l:line), l:pattern)
    let l:class=expand('%:t:r')
    let l:fqn = l:package . '.' . l:class
    exec 'Dispatch run-java.sh -r ' . l:fqn
endfunction

nnoremap <buffer><silent> <leader>mc :Dispatch! run-java.sh -cp<CR>
nnoremap <buffer><silent> <leader>mr :call <SID>RunJavaProgram()<CR>
nnoremap <buffer><silent> <F5> :call <SID>RunJavaProgram()<CR>


" *** Formatting
setlocal formatprg=google-java-format\ --aosp\ -
setlocal formatexpr=

function! s:OrganizeImports() abort
    setlocal formatprg=google-java-format\ --fix-imports-only\ -
    normal! magggqG`a
    setlocal formatprg=google-java-format\ --aosp\ -
endfunction

nnoremap <buffer><silent> <leader>ro :call <SID>OrganizeImports()<CR>
nnoremap <buffer><silent> <leader>mf magggqG`a
vnoremap <buffer><silent> <leader>mf gq

