highlight SLnormalmode ctermfg=236 ctermbg=111 guifg=#2b2b2b guibg=#89cddc
highlight SLinsertmode ctermfg=111 ctermbg=236 guifg=#89cddc guibg=#2b2b2b
highlight SLvisualmode ctermfg=236 ctermbg=215 guifg=#2b2b2b guibg=#ffa630
highlight SLflags ctermfg=236 ctermbg=215 guifg=#2b2b2b guibg=#ffa630

function! JqnoStatusLineFileEncoding() abort
    if &fileencoding !=# ''
        return &fileencoding
    endif
    if &encoding !=# ''
        return &encoding
    endif
    return 'unknown encoding'
endfunction

function! JqnoStatusLineFileFormat() abort
    if &fileformat !=# ''
        return &fileformat
    endif
    return 'unknown format'
endfunction

function! JqnoStatusLine() abort
    let l:is_active = '('. win_getid() .' == win_getid())'
    let l:has_flags = '(!&modifiable || &modified || &readonly || &previewwindow)'

    let l:statusline =
            \ '%#SLnormalmode#%{'. l:is_active .' && mode()=="n" ? "  N " : ""}' .
            \ '%#SLinsertmode#%{'. l:is_active .' && mode()=="i" ? "  I " : ""}' .
            \ '%#SLinsertmode#%{'. l:is_active .' && mode()=="r" ? "  R " : ""}' .
            \ '%#SLvisualmode#%{'. l:is_active .' && mode()=="v" ? "  V " : ""}' .
            \ '%*' .
            \ '%{'. l:is_active .' ? "" : "    "}' .
            \ ' ' .
            \ '%<' .
            \ '%f' .
            \ ' ' .
            \ '%{'. l:is_active .' && '. l:has_flags .' ? "[" : ""}' .
            \ '%{'. l:is_active .' && !&modifiable ? "-" : ""}' .
            \ '%{'. l:is_active .' && &modified ? "+" : ""}' .
            \ '%{'. l:is_active .' && &readonly ? "RO" : ""}' .
            \ '%{'. l:is_active .' && &previewwindow ? "P" : ""}' .
            \ '%{'. l:is_active .' && '. l:has_flags .' ? "]" : ""}' .
            \ '%*' .
            \ '%=' .
            \ '| ' .
            \ '%{'. l:is_active .' ? ' .
                \ 'JqnoStatusLineFileEncoding().' .
                \ '" | ".' .
                \ 'JqnoStatusLineFileFormat().' .
                \ '" | ".' .
                \ '&filetype.' .
                \ '" | "' .
            \ ' : ""}' .
            \ '#%n' .
            \ '%{'. l:is_active .' ? " | " . line("$")."L" : ""}' .
            \ ' | ' .
            \ '%l' .
            \ ':' .
            \ '%c' .
            \ ' '

    return l:statusline
endfunction

set laststatus=2
set noshowmode
set statusline=%!JqnoStatusLine()

