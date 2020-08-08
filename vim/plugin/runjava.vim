scriptencoding utf-8

function! s:RunJavaProgram(ask_jvm_params, ask_app_params) abort
    let cmd = 'Dispatch runjava.py ' . expand('%')
    if a:ask_jvm_params
        let in = input('JVM parameters: ')
        let cmd .= ' ' . in . ' --'
    endif
    if a:ask_app_params
        let in = input('Command-line parameters: ')
        let cmd .= ' ' . in
    endif
    exec cmd
endfunction

function! s:CreateMappings() abort
    nnoremap <buffer><silent> <leader>mr :call <SID>RunJavaProgram(v:false, v:false)<CR>
    nnoremap <buffer><silent> <leader>mR :call <SID>RunJavaProgram(v:false, v:true)<CR>
    nnoremap <buffer><silent> <leader>mj :call <SID>RunJavaProgram(v:true, v:false)<CR>
    nnoremap <buffer><silent> <leader>mJ :call <SID>RunJavaProgram(v:true, v:true)<CR>
    nnoremap <buffer><silent> <F5> :call <SID>RunJavaProgram(v:false, v:false)<CR>
endfunction

augroup RunJava
    autocmd!
    autocmd FileType java,scala,kotlin call <SID>CreateMappings()
augroup END

