compiler maven
call SetTabstop(4)


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

