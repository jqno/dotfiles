call SetTabstop(4)
setlocal wrap
setlocal conceallevel=2

function! s:Linkify() abort
    let l:url = shellescape(expand('<cWORD>'))
    let l:link = system('linkify.py ' . l:url)
    let l:chomped = substitute(l:link, '\n\+$', '', '')
    let l:prevchar = strpart(getline('.'), col('.') -2, 1)
    if l:prevchar ==# ' ' || l:prevchar ==# ''
        execute 'norm cW' . l:chomped
    else
        execute 'norm BcW' . l:chomped
    endif
endfunction

command! Linkify call <SID>Linkify()
nnoremap <silent> <leader>l :call <SID>Linkify()<CR>

