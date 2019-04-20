function SetupLsp(name, ispresent, server_info)
    if (a:ispresent)
        call lsp#register_server(a:server_info)

        nnoremap <silent><buffer> K :LspHover<CR>
        nnoremap <silent><buffer> <C-]> :LspDefinition<CR>
        nnoremap <silent><buffer> <leader>fr :LspReferences<CR>
        nnoremap <silent><buffer> <leader>mf :LspDocumentFormat<CR>
        nnoremap <silent><buffer> <leader>rr :LspRename<CR>

        setlocal omnifunc=lsp#complete
    else
        echohl ErrorMsg
        echom '[LSP] ' . a:name .' is not installed.'
        echohl NONE
    endif
endfunction
