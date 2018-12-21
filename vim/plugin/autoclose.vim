" ***
" Logic
" ***
function s:Open(open, close)
    return <SID>ExpandParenFully() ? a:open . a:close . "\<Left>" : a:open
endfunction

function s:Close(close)
    return <SID>NextChar() ==? a:close ? "\<Right>" : a:close
endfunction

function s:Toggle(char)
    return <SID>NextChar() == a:char ? "\<Right>" : <SID>ExpandParenFully() ? a:char . a:char . "\<Left>" : a:char
endfunction

function AutocloseSmartReturn()
    let l:prev = <SID>PrevChar()
    if l:prev !=? '' && index(['(', '[', '{'], l:prev) >= 0
        return "\<CR>\<Esc>O"
    else
        return "\<CR>"
    endif
endfunction

function AutocloseSmartBackspace()
    let l:prev = <SID>PrevChar()
    let l:next = <SID>NextChar()
    let l:doIt = (l:prev ==? '(' && l:next ==? ')') || (l:prev ==? '[' && l:next ==? ']') || (l:prev ==? '{' && l:next ==? '}') ||
               \ (l:prev ==? '''' && l:next ==? '''') || (l:prev ==? '"' && l:next ==? '"') || (l:prev ==? '`' && l:next ==? '`')
    if l:doIt
        return "\<BS>\<Del>"
    else
        return "\<BS>"
    endif
endfunction

function s:ExpandParenFully()
    let l:char = <SID>NextChar()
    return l:char ==? '' || index([' ', ')', ']', '}', '"', '''', '`'], l:char) >= 0
endfunction

function s:NextChar()
    return strpart(getline('.'), col('.')-1, 1)
endfunction

function s:PrevChar()
    return strpart(getline('.'), col('.')-2, 1)
endfunction


" ***
" Mappings
" ***
function s:AutocloseOpenParen()
    return <SID>Open('(', ')')
endfunction

function s:AutocloseCloseParen()
    return <SID>Close(')')
endfunction

function s:AutocloseOpenBracket()
    return <SID>Open('[', ']')
endfunction

function s:AutocloseCloseBracket()
    return <SID>Close(']')
endfunction

function s:AutocloseOpenBrace()
    return <SID>Open('{', '}')
endfunction

function s:AutocloseCloseBrace()
    return <SID>Close('}')
endfunction

function s:AutocloseOpenHook()
    return <SID>Open('<', '>')
endfunction

function s:AutocloseCloseHook()
    return <SID>Close('>')
endfunction

function s:AutocloseToggleDoubleQuote()
    return <SID>Toggle('"')
endfunction

function s:AutocloseToggleSingleQuote()
    return <SID>Toggle("'")
endfunction

function s:AutocloseToggleBacktick()
    return <SID>Toggle('`')
endfunction

inoremap <silent> <Plug>AutocloseOpenParen <C-R>=<SID>AutocloseOpenParen()<CR>
inoremap <silent> <Plug>AutocloseCloseParen <C-R>=<SID>AutocloseCloseParen()<CR>
inoremap <silent> <Plug>AutocloseOpenBracket <C-R>=<SID>AutocloseOpenBracket()<CR>
inoremap <silent> <Plug>AutocloseCloseBracket <C-R>=<SID>AutocloseCloseBracket()<CR>
inoremap <silent> <Plug>AutocloseOpenBrace <C-R>=<SID>AutocloseOpenBrace()<CR>
inoremap <silent> <Plug>AutocloseCloseBrace <C-R>=<SID>AutocloseCloseBrace()<CR>
inoremap <silent> <Plug>AutocloseOpenHook <C-R>=<SID>AutocloseOpenHook()<CR>
inoremap <silent> <Plug>AutocloseCloseHook <C-R>=<SID>AutocloseCloseHook()<CR>

inoremap <silent> <Plug>AutocloseToggleDoubleQuote <C-R>=<SID>AutocloseToggleDoubleQuote()<CR>
inoremap <silent> <Plug>AutocloseToggleSingleQuote <C-R>=<SID>AutocloseToggleSingleQuote()<CR>
inoremap <silent> <Plug>AutocloseToggleBacktick <C-R>=<SID>AutocloseToggleBacktick()<CR>

inoremap <silent> <Plug>AutocloseSmartBackspace <C-R>=AutocloseSmartBackspace()<CR>
inoremap <silent> <Plug>AutocloseSmartReturn <C-R>=AutocloseSmartReturn()<CR>


" ***
" Public functions
" ***
function AutocloseForProse()
    imap <buffer> ( <Plug>AutocloseOpenParen
    imap <buffer> ) <Plug>AutocloseCloseParen
    imap <buffer> [ <Plug>AutocloseOpenBracket
    imap <buffer> ] <Plug>AutocloseCloseBracket
    imap <buffer> { <Plug>AutocloseOpenBrace
    imap <buffer> } <Plug>AutocloseCloseBrace
    imap <buffer> " <Plug>AutocloseToggleDoubleQuote
    imap <buffer> <BS> <Plug>AutocloseSmartBackspace
    imap <buffer> <CR> <Plug>AutocloseSmartReturn
endfunction

function AutocloseForProgramming()
    imap <buffer> ( <Plug>AutocloseOpenParen
    imap <buffer> ) <Plug>AutocloseCloseParen
    imap <buffer> [ <Plug>AutocloseOpenBracket
    imap <buffer> ] <Plug>AutocloseCloseBracket
    imap <buffer> { <Plug>AutocloseOpenBrace
    imap <buffer> } <Plug>AutocloseCloseBrace
    imap <buffer> " <Plug>AutocloseToggleDoubleQuote
    imap <buffer> ' <Plug>AutocloseToggleSingleQuote
    imap <buffer> ` <Plug>AutocloseToggleBacktick
    imap <buffer> <BS> <Plug>AutocloseSmartBackspace
    imap <buffer> <CR> <Plug>AutocloseSmartReturn
endfunction

function AutocloseForXml()
    imap <buffer> ( <Plug>AutocloseOpenParen
    imap <buffer> ) <Plug>AutocloseCloseParen
    imap <buffer> [ <Plug>AutocloseOpenBracket
    imap <buffer> ] <Plug>AutocloseCloseBracket
    imap <buffer> { <Plug>AutocloseOpenBrace
    imap <buffer> } <Plug>AutocloseCloseBrace
    imap <buffer> < <Plug>AutocloseOpenHook
    imap <buffer> > <Plug>AutocloseCloseHook
    imap <buffer> " <Plug>AutocloseToggleDoubleQuote
    imap <buffer> ' <Plug>AutocloseToggleSingleQuote
    imap <buffer> ` <Plug>AutocloseToggleBacktick
    imap <buffer> <BS> <Plug>AutocloseSmartBackspace
    imap <buffer> <CR> <Plug>AutocloseSmartReturn
endfunction

