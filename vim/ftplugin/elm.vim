call SetTabstop(4)
call AutocloseForProgramming()

" To install elm-language-server: https://github.com/elm-tooling/elm-language-server
" Clone it, then run `npm run compile` and `npm install -g`
call SetupLsp('elm-language-server', executable('elm-language-server'), {
    \ 'name': 'elm-language-server',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'elm-language-server --stdio']},
    \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'elm.json'))},
    \ 'whitelist': ['elm'],
    \ 'initialization_options': {'runtime':'node', 'elmPath':'elm', 'elmFormatPath':'elm-format'}
    \ })

