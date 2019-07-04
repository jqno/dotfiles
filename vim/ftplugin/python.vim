call AutocloseForProgramming()

call SetupLsp('pyls', executable('pyls'), {
    \ 'name': 'pyls',
    \ 'cmd': {server_info->['pyls']},
    \ 'whitelist': ['python']
    \ })

