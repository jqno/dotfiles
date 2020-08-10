scriptencoding utf-8

function! s:CompileOpenJavaFiles() abort
    let buffers = map(filter(copy(getbufinfo()), 'v:val.listed'), 'v:val.name')
    let cmd = 'Dispatch runjava.py -c ' . join(buffers)
    exec cmd
endfunction

function! s:RunJavaProgram(ask_jvm_params, ask_app_params) abort
    let cmd = 'Dispatch runjava.py -r ' . expand('%')
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

function! s:CompileAndRunJavaProgram(ask_jvm_params, ask_app_params) abort
    call <SID>CompileOpenJavaFiles()
    call <SID>RunJavaProgram(a:ask_jvm_params, a:ask_app_params)
endfunction

function! s:CreateMappings() abort
    nnoremap <buffer><silent> <leader>mr :call <SID>CompileAndRunJavaProgram(v:false, v:false)<CR>
    nnoremap <buffer><silent> <leader>mR :call <SID>CompileAndRunJavaProgram(v:false, v:true)<CR>
    nnoremap <buffer><silent> <leader>mj :call <SID>CompileAndRunJavaProgram(v:true, v:false)<CR>
    nnoremap <buffer><silent> <leader>mJ :call <SID>CompileAndRunJavaProgram(v:true, v:true)<CR>
    nnoremap <buffer><silent> <F5> :call <SID>CompileAndRunJavaProgram(v:false, v:false)<CR>
endfunction

augroup RunJava
    autocmd!
    autocmd FileType java,scala,kotlin call <SID>CreateMappings()
augroup END

