call SetTabstop(4)

inoremap <expr><buffer> ( AutocloseOpen('(', ')')
inoremap <expr><buffer> ) AutocloseClose(')')
inoremap <expr><buffer> [ AutocloseOpen('[', ']')
inoremap <expr><buffer> ] AutocloseClose(']')
inoremap <expr><buffer> { AutocloseOpen('{', '}')
inoremap <expr><buffer> } AutocloseClose('}')
inoremap <expr><buffer> ' AutocloseToggle("'")
inoremap <expr><buffer> ` AutocloseToggle('`')
inoremap <expr><buffer> <BS> AutocloseSmartBackspace()
inoremap <expr><buffer> <CR> AutocloseSmartReturn()

setlocal omnifunc=syntaxcomplete#Complete

