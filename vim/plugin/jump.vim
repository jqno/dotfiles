let s:jqnoautoclose_punctuation = [ '.', ',', ':', ';', '?', '!', '=', '+', '-', '*', '/' ]
let s:jqnoautoclose_allclosers = [ ')', ']', '}', '>', '"', "'", '`' ]
let s:jqnoautoclose_parenclosers = [ ')', ']', '}', '>' ]

function! s:JqnoAutocloseSmartJump() abort
    " First, if a CoC jump is possible, do that.
    if exists('g:did_coc_loaded')
        if coc#jumpable()
            return "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump', ''])\<CR>"
        endif
    endif
    " Next, if at the end of the line and the next line contains a closer, jump to the end of that next line.
    if <SID>NextChar() ==? '' && index(s:jqnoautoclose_parenclosers, trim(getline(line('.')+1))) >= 0
        return "\<Down>\<End>"
    endif
    " Next, if the next char is punctuation, jump through that.
    if index(s:jqnoautoclose_punctuation, <SID>NextChar()) >= 0
        return "\<Right>"
    endif
    " Finally, jump through parens and quotes.
    let l:i = 0
    let l:result = ''
    while index(s:jqnoautoclose_allclosers, <SID>NextChar(l:i)) >= 0
        let l:result .= "\<Right>"
        let l:i += 1
    endwhile
    return l:result
endfunction

function! s:NextChar(i = 0) abort
    return strpart(getline('.'), col('.')-1+a:i, 1)
endfunction

inoremap <expr><silent> <C-L> <SID>JqnoAutocloseSmartJump()

