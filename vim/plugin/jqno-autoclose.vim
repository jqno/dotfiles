" ***
" Logic
" ***
function! AutocloseOpen(open, close) abort
    return <SID>ExpandParenFully(1) ? a:open . a:close . "\<Left>" : a:open
endfunction

function! AutocloseClose(close) abort
    return <SID>NextChar() ==? a:close ? "\<Right>" : a:close
endfunction

function! AutocloseToggle(char) abort
    return <SID>NextChar() == a:char ? "\<Right>" : <SID>ExpandParenFully(0) ? a:char . a:char . "\<Left>" : a:char
endfunction

function! AutocloseSmartReturn() abort
    let l:prev = <SID>PrevChar()
    if pumvisible()
        return "\<C-Y>"
    elseif l:prev !=? '' && index(['(', '[', '{'], l:prev) >= 0
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

function! AutocloseSmartJump() abort
    let l:i = 0
    let l:result = ''
    while index([')', ']', '}', '"', '''', '`'], <SID>NextChar(l:i)) >= 0
        let l:result .= "\<Right>"
        let l:i += 1
    endwhile
    return l:result
endfunction

function! s:ExpandParenFully(expandIfAfterWord) abort
    let l:nextchar = <SID>NextChar()
    let l:nextok = l:nextchar ==? '' || index([' ', ')', ']', '}', '"', '''', '`'], l:nextchar) >= 0
    let l:prevchar = <SID>PrevChar()
    let l:prevok = a:expandIfAfterWord || l:prevchar !~# '\w'
    return l:nextok && l:prevok
endfunction

function! s:NextChar(i = 0) abort
    return strpart(getline('.'), col('.')-1+a:i, 1)
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
    inoremap <expr><buffer> <C-L> AutocloseSmartJump()
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
    inoremap <expr><buffer> <C-L> AutocloseSmartJump()
endfunction

