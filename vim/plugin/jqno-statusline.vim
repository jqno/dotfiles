highlight SLnormalmode ctermfg=236 ctermbg=111 guifg=#2b2b2b guibg=#89cddc
highlight SLinsertmode ctermfg=111 ctermbg=236 guifg=#89cddc guibg=#2b2b2b
highlight SLvisualmode ctermfg=236 ctermbg=215 guifg=#2b2b2b guibg=#ffa630
highlight SLflags ctermfg=236 ctermbg=215 guifg=#2b2b2b guibg=#ffa630

function! JqnoStatusLineFileEncoding()
    if &fileencoding !=# ''
        return &fileencoding
    endif
    if &encoding !=# ''
        return &encoding
    endif
    return 'unknown encoding'
endfunction

function! JqnoStatusLineFileFormat()
    if &fileformat !=# ''
        return &fileformat
    endif
    return 'unknown format'
endfunction

function! JqnoStatusLineFileEncodingAndFormat()
    return '[' . JqnoStatusLineFileEncoding() . ',' . JqnoStatusLineFileFormat() . ']'
endfunction

function! JqnoStatusLine()
    let l:is_active='('. win_getid() .' == win_getid())'
    let l:has_flags='(!&modifiable || &modified || &readonly || &previewwindow)'

    let l:statusline=''
    let l:statusline.='%#SLnormalmode#%{'. l:is_active .' && mode()=="n" ? "  N " : ""}'
    let l:statusline.='%#SLinsertmode#%{'. l:is_active .' && mode()=="i" ? "  I " : ""}'
    let l:statusline.='%#SLinsertmode#%{'. l:is_active .' && mode()=="r" ? "  R " : ""}'
    let l:statusline.='%#SLvisualmode#%{'. l:is_active .' && mode()=="v" ? "  V " : ""}'
    let l:statusline.='%*'  " reset color
    let l:statusline.='%{'. l:is_active .' ? "" : "    "}'
    let l:statusline.=' '
    let l:statusline.='%<'  " truncate here if the statusline gets too long
    let l:statusline.='%f'  " short filename
    let l:statusline.=' '
    let l:statusline.='%{'. l:is_active .' && '. l:has_flags .' ? "[" : ""}'
    let l:statusline.='%{'. l:is_active .' && !&modifiable ? "-" : ""}'
    let l:statusline.='%{'. l:is_active .' && &modified ? "+" : ""}'
    let l:statusline.='%{'. l:is_active .' && &readonly ? "RO" : ""}'
    let l:statusline.='%{'. l:is_active .' && &previewwindow ? "P" : ""}'
    let l:statusline.='%{'. l:is_active .' && '. l:has_flags .' ? "]" : ""}'
    let l:statusline.='%*'  " reset color
    let l:statusline.='%='  " right align
    let l:statusline.=' '
    let l:statusline.='%{'. l:is_active .' ? JqnoStatusLineFileEncodingAndFormat() : ""}'
    let l:statusline.=' '
    let l:statusline.='%{&filetype}'
    let l:statusline.=' '
    let l:statusline.='#%n' " buffer number
    let l:statusline.=' '
    let l:statusline.='%l'  " current line
    let l:statusline.=':'
    let l:statusline.='%c'  " current column
    let l:statusline.=' '
    let l:statusline.='%P'

    return l:statusline
endfunction

set laststatus=2
set noshowmode
set statusline=%!JqnoStatusLine()

