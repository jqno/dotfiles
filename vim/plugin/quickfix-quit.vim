" Taken from https://vim.fandom.com/wiki/Automatically_quit_Vim_if_quickfix_window_is_the_last

augroup LastWindow
    autocmd!
    autocmd BufEnter * call <SID>LastWindow()
augroup END

function! s:LastWindow() abort
  " if the window is quickfix go on
  if &buftype ==# 'quickfix'
    " if this window is last on screen quit without warning
    if winbufnr(2) == -1
      quit!
    endif
  endif
endfunction
