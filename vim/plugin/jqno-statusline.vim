scriptencoding utf-8

augroup JqnoStatusLineColors
    autocmd!
    autocmd ColorScheme * call JqnoStatusLineHighlights()
augroup END

function! JqnoStatusLineHighlights() abort
    highlight SLnormalmode ctermfg=236 ctermbg=111 guifg=#2b2b2b guibg=#89cddc
    highlight SLinsertmode ctermfg=111 ctermbg=236 guifg=#89cddc guibg=#2b2b2b
    highlight SLvisualmode ctermfg=236 ctermbg=215 guifg=#2b2b2b guibg=#ffa630
    highlight SLaleok ctermfg=65 ctermbg=151 guifg=#5c7b54 guibg=#acc8a5
    highlight SLaleerror ctermfg=215 ctermbg=124 guifg=#ffa630 guibg=#ae2e2b
    highlight SLalewarning ctermfg=124 ctermbg=215 guifg=#ae2e2b guibg=#ffa630
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
        let l:lsc_status = LSCServerStatus()
        if l:lsc_status ==# 'running'
            let l:lsc = 'λ '
        elseif l:lsc_status ==# 'unexpected exit' || l:lsc_status ==# 'failed'
            let l:lsc = '! '
        else
            let l:lsc = ''
        endif
        return l:lsc . &filetype
    endif
    return '-'
endfunction

function! JqnoStatusLine() abort
    let l:is_active = '('. win_getid() .' == win_getid())'
    let l:is_active_not_terminal = l:is_active . ' && term_getstatus(bufnr("%")) == ""'

    let l:ale_counts = ale#statusline#Count(bufnr('%'))
    let l:ale_errors = l:ale_counts.error + l:ale_counts.style_error
    let l:ale_warnings = l:ale_counts.total - l:ale_errors

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
                \ '%#SLaleok#' .
                \ (l:ale_counts.total == 0 ? '%{' . l:is_active_not_terminal . ' ? " ✓ " : ""}' : '') .
                \ '%#SLaleerror#' .
                \ (l:ale_errors > 0 ? '%{' . l:is_active_not_terminal . ' ? printf(" ✗%d ", ' . l:ale_errors. ') : ""}' : '') .
                \ '%#SLalewarning#' .
                \ (l:ale_warnings > 0 ? '%{' . l:is_active_not_terminal . ' ? printf(" ◆%d ", ' . l:ale_warnings . ') : ""}' : '') .
                \ '%*' .
                \ '  ' .
            \ '%{'. l:is_active_not_terminal .' ? ' .
                \ ' ' .
                \ 'JqnoStatusLineFileEncoding().' .
                \ '" | ".' .
                \ 'JqnoStatusLineFileFormat().' .
                \ '" | ".' .
                \ 'JqnoStatusLineFileType().' .
                \ '" | ".' .
                \ 'line(".").' .
                \ '":".' .
                \ 'col(".").' .
                \ '" ".' .
                \ '"' . LineNoIndicator() . '".' .
                \ '" "' .
            \ ' : ""}'

    return l:statusline
endfunction

set laststatus=2
set noshowmode
set statusline=%!JqnoStatusLine()
call JqnoStatusLineHighlights()

