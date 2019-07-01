" ***
" Logic
" ***
function! AutocloseOpen(open, close) abort
    return <SID>ExpandParenFully() ? a:open . a:close . "\<Left>" : a:open
endfunction

function! AutocloseClose(close) abort
    return <SID>NextChar() ==? a:close ? "\<Right>" : a:close
endfunction

function! AutocloseToggle(char) abort
    return <SID>NextChar() == a:char ? "\<Right>" : <SID>ExpandParenFully() ? a:char . a:char . "\<Left>" : a:char
endfunction

function! AutocloseSmartReturn() abort
    let l:prev = <SID>PrevChar()
    if l:prev !=? '' && index(['(', '[', '{'], l:prev) >= 0
        return "\<CR>\<Esc>O"
    else
        return "\<CR>"
    endif
endfunction

function! AutocloseSmartBackspace() abort
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

function! s:ExpandParenFully() abort
    let l:char = <SID>NextChar()
    return l:char ==? '' || index([' ', ')', ']', '}', '"', '''', '`'], l:char) >= 0
endfunction

function! s:NextChar() abort
    return strpart(getline('.'), col('.')-1, 1)
endfunction

function! s:PrevChar() abort
    return strpart(getline('.'), col('.')-2, 1)
endfunction


" ***
" Public functions
" ***
function! AutocloseForProse() abort
    inoremap <expr><buffer> ( AutocloseOpen('(', ')')
    inoremap <expr><buffer> ) AutocloseClose(')')
    inoremap <expr><buffer> [ AutocloseOpen('[', ']')
    inoremap <expr><buffer> ] AutocloseClose(']')
    inoremap <expr><buffer> { AutocloseOpen('{', '}')
    inoremap <expr><buffer> } AutocloseClose('}')
    inoremap <expr><buffer> " AutocloseToggle('"')
    inoremap <expr><buffer> ` AutocloseToggle('`')
    inoremap <expr><buffer> <BS> AutocloseSmartBackspace()
    inoremap <expr><buffer> <CR> AutocloseSmartReturn()
endfunction

function! AutocloseForProgramming() abort
    inoremap <expr><buffer> ( AutocloseOpen('(', ')')
    inoremap <expr><buffer> ) AutocloseClose(')')
    inoremap <expr><buffer> [ AutocloseOpen('[', ']')
    inoremap <expr><buffer> ] AutocloseClose(']')
    inoremap <expr><buffer> { AutocloseOpen('{', '}')
    inoremap <expr><buffer> } AutocloseClose('}')
    inoremap <expr><buffer> " AutocloseToggle('"')
    inoremap <expr><buffer> ' AutocloseToggle("'")
    inoremap <expr><buffer> ` AutocloseToggle('`')
    inoremap <expr><buffer> <BS> AutocloseSmartBackspace()
    inoremap <expr><buffer> <CR> AutocloseSmartReturn()
endfunction

