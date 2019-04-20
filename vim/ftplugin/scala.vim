compiler maven
call AutocloseForProgramming()


" Metals / LSP requires Bloop. I haven't tried that yet.
" * See https://raw.githubusercontent.com/scalameta/metals/019283d2704f33c71f10059270131287e0ec601b/docs/editors/vim.md
" * https://scalameta.org/metals/docs/build-tools/sbt.html

call SetupLsp('Metals', executable('metals-vim'), {
    \ 'name': 'Metals',
    \ 'cmd': {server_info -> ['metals-vim']},
    \ 'whitelist': ['scala'],
    \ })

function! ScalaLspSendRequest(command)
    call lsp#send_request('Metals', {
        \ 'method': 'workspace/executeCommand',
        \ 'params': {'command': a:command},
        \ })
endfunction

function! ScalaLspBuildImport()
    call ScalaLspSendRequest('build-import')
endfunction

function! ScalaLspBuildConnect()
    call ScalaLspSendRequest('build-connect')
endfunction

