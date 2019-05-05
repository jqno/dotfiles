" Visualize tabs and trailing spaces.

let s:toggleListchars=1
function! ToggleListChars()
    if s:toggleListchars==0
        set list
        set listchars=tab:჻\ ,trail:·,precedes:←,extends:→,nbsp:·
        let s:toggleListchars=1
    else
        set nolist
        set listchars=
        let s:toggleListchars=0
    endif
endfunction

call ToggleListChars()

