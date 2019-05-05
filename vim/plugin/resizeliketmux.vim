" ***************************************
" ***  Tmux-like window resizing
" ***************************************

" Shamelessly stolen from http://stackoverflow.com/a/36653470/127863

function! s:IsEdgeWindowSelected(direction)
    let l:curwindow = winnr()
    exec 'wincmd '.a:direction
    let l:result = l:curwindow == winnr()

    if (!l:result)
        " Go back to the previous window
        exec l:curwindow.'wincmd w'
    endif

    return l:result
endfunction

function! s:GetAction(direction)
    let l:keys = ['h', 'j', 'k', 'l']
    let l:actions = ['vertical resize -', 'resize +', 'resize -', 'vertical resize +']
    return get(l:actions, index(l:keys, a:direction))
endfunction

function! s:GetOpposite(direction)
    let l:keys = ['h', 'j', 'k', 'l']
    let l:opposites = ['l', 'k', 'j', 'h']
    return get(l:opposites, index(l:keys, a:direction))
endfunction

function! ResizeLikeTmux(direction, amount)
    " v >
    if (a:direction ==# 'j' || a:direction ==# 'l')
        if <SID>IsEdgeWindowSelected(a:direction)
            let l:opposite = <SID>GetOpposite(a:direction)
            let l:curwindow = winnr()
            exec 'wincmd '.l:opposite
            let l:action = <SID>GetAction(a:direction)
            exec l:action.a:amount
            exec l:curwindow.'wincmd w'
            return
        endif
    " < ^
    elseif (a:direction ==# 'h' || a:direction ==# 'k')
        let l:opposite = <SID>GetOpposite(a:direction)
        if <SID>IsEdgeWindowSelected(l:opposite)
            let l:curwindow = winnr()
            exec 'wincmd '.a:direction
            let l:action = <SID>GetAction(a:direction)
            exec l:action.a:amount
            exec l:curwindow.'wincmd w'
            return
        endif
    endif

    let l:action = <SID>GetAction(a:direction)
    exec l:action.a:amount
endfunction

