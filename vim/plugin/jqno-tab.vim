function! JqnoTab()
    if pumvisible()
        return "\<C-N>"
    endif

    let line = getline('.')
    let substr = strpart(line, -1, col('.') + 1)
    let substr = matchstr(substr, "[^ \t]*$")

    let only_whitespace = strlen(substr) == 0
    if (only_whitespace)
        return "\<Tab>"
    endif

    let has_slash = match(substr, '\/') != -1
    let has_html_slash = match(substr, '<\/') != -1
    if (has_slash && !has_html_slash)
        return "\<C-X>\<C-F>"
    endif

    if exists('&omnifunc') && &omnifunc !=# ''
        return "\<C-X>\<C-O>"
    endif

    return "\<C-X>\<C-P>"
endfunction

inoremap <expr><silent> <Tab> JqnoTab()

