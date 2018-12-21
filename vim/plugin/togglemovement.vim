" Taken from http://ddrscott.github.io/blog/2016/vim-toggle-movement/
"
function ToggleMovement(firstOp, thenOp)
  let pos = getpos('.')
  execute 'normal! ' . a:firstOp
  if pos == getpos('.')
    execute 'normal! ' . a:thenOp
  endif
endfunction

