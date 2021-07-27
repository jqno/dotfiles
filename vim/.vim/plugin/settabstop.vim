scriptencoding utf-8

" Define a set of tabstop settings and raise a flag if we have done so in this buffer
function SetTabstop(stop)
    exec 'setlocal expandtab smarttab tabstop=' . a:stop . ' shiftwidth=' . a:stop . ' softtabstop=' . a:stop
    let b:TabstopDefined = '¯\_(ツ)_/¯'
endfunction

