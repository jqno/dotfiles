call SetTabstop(2)
call AutocloseForProgramming()

if executable('typescript-language-server')
    call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \ 'whitelist': ['typescript', 'typescript.tsx'],
        \ })
else
    echohl ErrorMsg
    echom '`typescript-language-server` is not installed.'
    echohl NONE
endif

setlocal omnifunc=lsp#complete

