scriptencoding utf-8

augroup JqnoStatusLineColors
    autocmd!
    autocmd ColorScheme * call JqnoStatusLineHighlights()
augroup END

function! JqnoStatusLineHighlights() abort
    highlight link SLnormalmode StatusLine
    highlight link SLinsertmode Constant
    highlight link SLvisualmode Visual
    highlight link SLok DiffAdd
    highlight link SLerror DiffDelete
    highlight link SLwarning DiffChange
endfunction

function! JqnoStatusLineFileEncoding() abort
    let l:result = &fileencoding
    if l:result ==# ''
        let l:result = &encoding
    endif
    if l:result ==# ''
        let l:result = 'unknown encoding'
    endif

    if l:result !=# 'utf-8'
        return l:result . ' │ '
    endif
    return ''
endfunction

function! JqnoStatusLineFileFormat() abort
    let l:result = &fileformat
    if l:result ==# ''
        let l:result = 'unknown format'
    endif

    if l:result !=# 'unix'
        return l:result . ' │ '
    endif
    return ''
endfunction

function! JqnoStatusLineFileType() abort
    if &filetype !=# ''
        return &filetype . ' │ '
    endif
    return ''
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

    let l:lsp_status = exists('g:did_coc_loaded') ? coc#status() : ''
    let l:lsp_status = len(l:lsp_status) == 0 ? '' : l:lsp_status . ' │ '

    let l:ok = l:ale_ok
    let l:ok = len(l:ok) == 0 ? '' : ' ' . l:ok . ' '
    let l:warning = l:ale_warning
    let l:warning = len(l:warning) == 0 ? '' : '  ' . l:warning . ' '
    let l:error = l:ale_error
    let l:error = len(l:error) == 0 ? '' : '  ' . l:error . ' '

    let l:encoding = JqnoStatusLineFileEncoding()
    let l:format = JqnoStatusLineFileFormat()

    let l:statusline =
            \ '%#SLnormalmode#%{'. l:is_active .' && mode()=="n" ? "  N │" : ""}' .
            \ '%#SLinsertmode#%{'. l:is_active .' && mode()=="t" ? "  T  " : ""}' .
            \ '%#SLinsertmode#%{'. l:is_active .' && mode()=="i" ? "  I  " : ""}' .
            \ '%#SLinsertmode#%{'. l:is_active .' && mode()=="r" ? "  R  " : ""}' .
            \ '%#SLvisualmode#%{'. l:is_active .' && (mode()=="v" || mode()=="") ? "  V  " : ""}' .
            \ '%*' .
            \ '%{' . l:is_active .' ? "" : "     "}' .
            \ ' ' .
            \ '#%n' .
            \ '%*' .
            \ ' │ ' .
            \ '%<' .
            \ '%f' .
            \ ' ' .
            \ '%{'. l:is_active .' && &readonly ? "│ RO " : ""}' .
            \ '%{'. l:is_active .' && &previewwindow ? "│ P " : ""}' .
            \ '%{'. l:is_active_not_terminal .' && !&modifiable ? "│ - " : ""}' .
            \ '%{'. l:is_active_not_terminal .' && &modified ? "│ + " : ""}' .
            \ '%*' .
            \ '%=' .
            \ ' ' .
            \ '%{' . l:is_active_not_terminal . ' ? "' . l:lsp_status . '" : "" }' .
            \ '%{' . l:is_active_not_terminal . ' ? JqnoStatusLineFileEncoding() : "" }' .
            \ '%{' . l:is_active_not_terminal . ' ? JqnoStatusLineFileFormat() : "" }' .
            \ '%{' . l:is_active_not_terminal . ' ? JqnoStatusLineFileType() : "" }' .
            \ '%{' . l:is_active_not_terminal . ' ? line(".") . ":" . col(".") . " " : "" }' .
            \ '%{' . l:is_active_not_terminal . ' ? LineNoIndicator() : "" }' .
            \ ' ' .
            \ '%#SLok#%{' . l:is_active_not_terminal . ' ? "' . l:ok . '" : "" }' .
            \ '%#SLwarning#%{' . l:is_active_not_terminal . ' ? "' . l:warning . '" : "" }' .
            \ '%#SLerror#%{' . l:is_active_not_terminal . ' ? "' . l:error . '" : "" }' .
            \ '%*'

    return l:statusline
endfunction

set laststatus=2
set noshowmode
set statusline=%!JqnoStatusLine()
call JqnoStatusLineHighlights()

