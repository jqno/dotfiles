compiler maven
call SetTabstop(4)
setlocal formatprg=google-java-format\ --aosp\ -

function s:OrganizeImports() abort
    setlocal formatprg=google-java-format\ --fix-imports-only\ -
    normal! magggqG`a
    setlocal formatprg=google-java-format\ --aosp\ -
endfunction

nnoremap <buffer> <leader>ro :call <SID>OrganizeImports()<CR>

