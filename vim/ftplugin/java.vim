compiler maven
call SetTabstop(4)
call AutocloseForProgramming()

" To install Eclipse JDT: https://github.com/prabirshrestha/vim-lsp/wiki/Servers-Java
let s:path = '~/.lsp/eclipse.jdt.ls'
let s:jdt_present=executable('java') && filereadable(expand(s:path . '/plugins/org.eclipse.equinox.launcher_1.5.300.v20190213-1655.jar'))
call SetupLsp('Eclipse JDT', s:jdt_present, {
    \ 'name': 'eclipse.jdt.ls',
    \ 'cmd': {server_info->[
    \     'java',
    \     '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    \     '-Dosgi.bundles.defaultStartLevel=4',
    \     '-Declipse.product=org.eclipse.jdt.ls.core.product',
    \     '-Dlog.level=ALL',
    \     '-noverify',
    \     '-Dfile.encoding=UTF-8',
    \     '-Xmx1G',
    \     '-jar',
    \     expand(s:path . '/plugins/org.eclipse.equinox.launcher_1.5.300.v20190213-1655.jar'),
    \     '-configuration',
    \     expand(s:path . '/config_win'),
    \     '-data',
    \     getcwd()
    \ ]},
    \ 'whitelist': ['java'],
    \ })

