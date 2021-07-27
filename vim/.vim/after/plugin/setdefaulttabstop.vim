" Set a nice default tab stop level if it wasn't already set by an autocmd
if !exists('b:TabstopDefined')
    call SetTabstop(2)
endif
