scriptencoding utf-8

let s:OPEN = ''
let s:CLOSE = ''
let s:PIPE = '│'

augroup JqnoStatusLineColors
    autocmd!
    autocmd ColorScheme * call JqnoStatusLineHighlights()
augroup END

function! JqnoStatusLineHighlights() abort
    highlight link SLnormalmode WildMenu
    highlight link SLvisualmode Visual
    highlight link SLok DiffAdd
    highlight link SLerror DiffDelete
    highlight link SLwarning DiffChange

    let l:slid = synIDtrans(hlID('StatusLine'))
    let l:ncid = synIDtrans(hlID('StatusLineNC'))
    let l:ctermfg = synIDattr(l:slid, 'fg#', 'cterm')
    let l:ctermbg = synIDattr(l:ncid, 'bg#', 'cterm')
    let l:guifg = synIDattr(l:slid, 'fg#', 'gui')
    let l:guibg = synIDattr(l:ncid, 'bg#', 'gui')
    exe printf('hi! StatusLine ctermfg=White ctermbg=%s guifg=White guibg=%s', l:ctermbg, l:guibg)

    let l:id = synIDtrans(hlID('Constant'))
    let l:ctermfg = synIDattr(l:id, 'fg#', 'cterm')
    let l:guifg = synIDattr(l:id, 'fg#', 'gui')
    exe printf('hi SLinsertmode ctermfg=%s ctermbg=Black guifg=%s guibg=Black', l:ctermfg, l:guifg)

    call JqnoStatusLineHighlightInvert('SLnormalmode')
    call JqnoStatusLineHighlightInvert('SLinsertmode')
    call JqnoStatusLineHighlightInvert('SLvisualmode')
    call JqnoStatusLineHighlightInvert('SLok')
    call JqnoStatusLineHighlightInvert('SLerror')
    call JqnoStatusLineHighlightInvert('SLwarning')
endfunction

function! JqnoStatusLineHighlightInvert(group) abort
    let l:fgId = synIDtrans(hlID(a:group))
    let l:bgId = synIDtrans(hlID('StatusLineNC'))
    let l:ctermfg = synIDattr(l:fgId, 'bg#', 'cterm')
    let l:ctermfg = empty(l:ctermfg) ? 'Black': l:ctermfg
    let l:ctermbg = synIDattr(l:bgId, 'bg#', 'cterm')
    let l:ctermbg = empty(l:ctermbg) ? '#000000': l:ctermbg
    let l:guifg = synIDattr(l:fgId, 'bg#', 'gui')
    let l:guifg = empty(l:guifg) ? 'Black': l:guifg
    let l:guibg = synIDattr(l:bgId, 'bg#', 'gui')
    let l:guibg = empty(l:guibg) ? '#000000': l:guibg
    let l:grp = a:group . 'I'
    exe printf('hi %s ctermfg=%s ctermbg=%s guifg=%s guibg=%s', l:grp, l:ctermfg, l:ctermbg, l:guifg, l:guibg)
endfunction

function! JqnoStatusLineFilename() abort
    let l:tab = tabpagenr()
    let l:buflist = tabpagebuflist(l:tab)
    let l:winnr = tabpagewinnr(l:tab)
    let l:filename = expand('#' . l:buflist[l:winnr - 1] . ':t')
    let l:result = empty(l:filename) ? '⊥' : l:filename
    return l:result
endfunction

function! JqnoStatusLineModifiers(is_not_terminal) abort
    let l:result = ''
    let l:result .= &readonly ? 'RO' : ''
    let l:result .= &readonly && &previewwindow ? s:PIPE : ''
    let l:result .= &previewwindow ? 'P' : ''
    return l:result
endfunction

function! JqnoStatusLineModification() abort
    let l:result = ''
    let l:result .= &modifiable ? '' : '-'
    let l:result .= &modified ? '+' : ''
    return l:result
endfunction

function! JqnoStatusLineFileMeta() abort
    let l:fileencoding = &fileencoding
    if l:fileencoding ==# ''
        let l:fileencoding = &encoding
    endif
    if l:fileencoding ==# ''
        let l:fileencoding = 'unknown encoding'
    endif
    if l:fileencoding ==# 'utf-8'
        let l:fileencoding = ''
    endif
    if l:fileencoding !=# ''
        let l:fileencoding .= s:PIPE
    endif

    let l:fileformat = &fileformat
    if l:fileformat ==# ''
        let l:fileformat = 'unknown format'
    endif
    if l:fileformat ==# 'unix'
        let l:fileformat = ''
    endif
    if l:fileformat !=# ''
        let l:fileformat .= s:PIPE
    endif

    let l:filetype = &filetype
    if l:filetype ==# ''
        let l:filetype = '⊥'
    endif

    return l:fileencoding . l:fileformat . l:filetype
endfunction

function! JqnoBubble(b, text, group, is_a_fn = v:false) abort
    let l:result = ''
    if !empty(a:text)
        let l:result .= '%#' . a:group . 'I#%{' . a:b . ' ? "  ' . s:OPEN . '" : ""}'
        if a:is_a_fn
            let l:result .= '%#' . a:group . '#%{' . a:b . ' ? ' . a:text . ' : ""}'
        else
            let l:result .= '%#' . a:group . '#%{' . a:b . ' ? "' . a:text . '" : ""}'
        endif
        let l:result .= '%#' . a:group . 'I#%{' . a:b . ' ? "' . s:CLOSE . '" : ""}'
    endif
    return l:result
endfunction

function! JqnoDoubleBubble(b, text1, group1, text2, group2) abort
    let l:result = ''
    let l:result .= '%#' . a:group1 . 'I#%{' . a:b . ' ? "  ' . s:OPEN . '" : ""}'
    let l:result .= '%#' . a:group1 . '#%{' . a:b . ' ? "' . a:text1 . ' " : ""}'
    let l:result .= '%#' . a:group2 . '#%{' . a:b . ' ? "  ' . a:text2 . '" : ""}'
    let l:result .= '%#' . a:group2 . 'I#%{' . a:b . ' ? "' . s:CLOSE . '" : ""}'
    return l:result
endfunction

function! JqnoStatusLine() abort
    let l:is_active = '('. win_getid() .' == win_getid())'
    let l:is_not_active = '('. win_getid() .' != win_getid())'
    let l:is_not_terminal = 'term_getstatus(bufnr("%")) == ""'
    let l:is_active_not_terminal = l:is_active . ' && ' . l:is_not_terminal

    let l:mods = JqnoStatusLineModifiers(l:is_not_terminal)
    let l:modification = JqnoStatusLineModification()

    let l:ale_counts = ale#statusline#Count(bufnr('%'))
    let l:ale_error_count = l:ale_counts.error + l:ale_counts.style_error
    let l:ale_warning_count = l:ale_counts.total - l:ale_error_count
    let l:ale_ok = l:ale_counts.total == 0 ? '✔' : ''
    let l:ale_warning = l:ale_warning_count > 0 ? printf('◆%d', l:ale_warning_count) : ''
    let l:ale_error = l:ale_error_count > 0 ? printf('✗%d', l:ale_error_count) : ''

    let l:lsp_status = exists('g:did_coc_loaded') ? coc#status() : ''

    let l:statusline = ''
    let l:statusline .= JqnoBubble(l:is_active . ' && mode() == "n"', 'N', 'SLnormalmode')
    let l:statusline .= JqnoBubble(l:is_active . ' && mode() == "t"', 'T', 'SLinsertmode')
    let l:statusline .= JqnoBubble(l:is_active . ' && mode() == "i"', 'I', 'SLinsertmode')
    let l:statusline .= JqnoBubble(l:is_active . ' && mode() == "r"', 'R', 'SLinsertmode')
    let l:statusline .= JqnoBubble(l:is_active . ' && mode() == "v" || mode() == ""', 'V', 'SLvisualmode')
    let l:statusline .= JqnoBubble(l:is_active, 'JqnoStatusLineFilename()', 'SLnormalmode', v:true)
    let l:statusline .= '%#StatusLineNC#%{' . l:is_not_active . ' ? "       " . JqnoStatusLineFilename() : ""}'
    let l:statusline .= '%<'
    let l:statusline .= JqnoBubble(l:is_active, l:mods, 'SLnormalmode')
    let l:statusline .= JqnoBubble(l:is_active_not_terminal, l:modification, 'SLnormalmode')
    let l:statusline .= '%='
    let l:statusline .= JqnoBubble(l:is_active_not_terminal, l:lsp_status, 'SLvisualmode')
    let l:statusline .= JqnoBubble(l:is_active_not_terminal, JqnoStatusLineFileMeta(), 'SLnormalmode')
    let l:statusline .= JqnoBubble(l:is_active_not_terminal, line('.') . ':' . col('.') . s:PIPE . line('$'), 'SLnormalmode')
    let l:statusline .= JqnoBubble(l:is_active_not_terminal, l:ale_ok, 'SLok')
    if empty(l:ale_warning) || empty(l:ale_error)
        let l:statusline .= JqnoBubble(l:is_active_not_terminal, l:ale_warning, 'SLwarning')
        let l:statusline .= JqnoBubble(l:is_active_not_terminal, l:ale_error, 'SLerror')
    else
        let l:statusline .= JqnoDoubleBubble(l:is_active_not_terminal, l:ale_warning, 'SLwarning', l:ale_error, 'SLerror')
    endif
    let l:statusline .= ' '

    return l:statusline
endfunction

set laststatus=2
set noshowmode
set statusline=%!JqnoStatusLine()
call JqnoStatusLineHighlights()

