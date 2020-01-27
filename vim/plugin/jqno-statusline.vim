scriptencoding utf-8

augroup JqnoStatusLineColors
    autocmd!
    autocmd ColorScheme * call JqnoStatusLineHighlights()
augroup END

function! JqnoStatusLineHighlights() abort
    highlight SLnormalmode ctermfg=236 ctermbg=111 guifg=#2b2b2b guibg=#89cddc
    highlight SLinsertmode ctermfg=111 ctermbg=236 guifg=#89cddc guibg=#2b2b2b
    highlight SLvisualmode ctermfg=236 ctermbg=215 guifg=#2b2b2b guibg=#ffa630
    highlight SLok ctermfg=65 ctermbg=151 guifg=#5c7b54 guibg=#acc8a5
    highlight SLerror ctermfg=215 ctermbg=124 guifg=#ffa630 guibg=#ae2e2b
    highlight SLwarning ctermfg=124 ctermbg=215 guifg=#ae2e2b guibg=#ffa630
endfunction

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

function! JqnoStatusLineFileType() abort
    if &filetype !=# ''
        return &filetype
    endif
    return '-'
endfunction

function! JqnoStatusLine() abort
    let l:is_active = '('. win_getid() .' == win_getid())'
    let l:is_active_not_terminal = l:is_active . ' && term_getstatus(bufnr("%")) == ""'

    let l:ale_counts = ale#statusline#Count(bufnr('%'))
    let l:ale_error_count = l:ale_counts.error + l:ale_counts.style_error
    let l:ale_warning_count = l:ale_counts.total - l:ale_error_count
    let l:ale_ok = l:ale_counts.total == 0 ? '✓' : ''
    let l:ale_error = l:ale_error_count > 0 ? printf('✗%d', l:ale_error_count) : ''
    let l:ale_warning = l:ale_warning_count > 0 ? printf('◆%d', l:ale_warning_count) : ''

    let l:lsp_status = LSCServerStatus()
    let l:lsp_ok = l:lsp_status ==# 'running' ? 'λ' : ''
    let l:lsp_error = l:lsp_status ==# 'unexpected exit' || l:lsp_status ==# 'failed' ? 'λ' : ''

    let l:ok = l:ale_ok . l:lsp_ok
    let l:ok = len(l:ok) == 0 ? '' : ' ' . l:ok . ' '
    let l:warning = l:ale_warning
    let l:warning = len(l:warning) == 0 ? '' : '  ' . l:warning . ' '
    let l:error = l:ale_error . l:lsp_error
    let l:error = len(l:error) == 0 ? '' : '  ' . l:error . ' '

    let l:statusline =
            \ '%#SLnormalmode#%{'. l:is_active .' && mode()=="n" ? "  N |" : ""}' .
            \ '%#SLinsertmode#%{'. l:is_active .' && mode()=="t" ? "  T  " : ""}' .
            \ '%#SLinsertmode#%{'. l:is_active .' && mode()=="i" ? "  I  " : ""}' .
            \ '%#SLinsertmode#%{'. l:is_active .' && mode()=="r" ? "  R  " : ""}' .
            \ '%#SLvisualmode#%{'. l:is_active .' && (mode()=="v" || mode()=="") ? "  V  " : ""}' .
            \ '%*' .
            \ '%{' . l:is_active .' ? "" : "     "}' .
            \ ' ' .
            \ '#%n' .
            \ '%*' .
            \ ' | ' .
            \ '%<' .
            \ '%f' .
            \ ' ' .
            \ '%{'. l:is_active .' && &readonly ? "| RO " : ""}' .
            \ '%{'. l:is_active .' && &previewwindow ? "| P " : ""}' .
            \ '%{'. l:is_active_not_terminal .' && !&modifiable ? "| - " : ""}' .
            \ '%{'. l:is_active_not_terminal .' && &modified ? "| + " : ""}' .
            \ '%*' .
            \ '%=' .
            \ '  ' .
            \ '%#SLok#%{' . l:is_active_not_terminal . ' ? "' . l:ok . '" : "" }' .
            \ '%#SLwarning#%{' . l:is_active_not_terminal . ' ? "' . l:warning . '" : "" }' .
            \ '%#SLerror#%{' . l:is_active_not_terminal . ' ? "' . l:error . '" : "" }' .
            \ '%*' .
            \ ' ' .
            \ '%{' . l:is_active_not_terminal . ' ? JqnoStatusLineFileEncoding() . " | " : "" }' .
            \ '%{' . l:is_active_not_terminal . ' ? JqnoStatusLineFileFormat() . " | " : "" }' .
            \ '%{' . l:is_active_not_terminal . ' ? JqnoStatusLineFileType() . " | " : "" }' .
            \ '%{' . l:is_active_not_terminal . ' ? line(".") . ":" . col(".") . " " : "" }' .
            \ '%{' . l:is_active_not_terminal . ' ? LineNoIndicator() . " " : "" }'

    return l:statusline
endfunction

set laststatus=2
set noshowmode
set statusline=%!JqnoStatusLine()
call JqnoStatusLineHighlights()

