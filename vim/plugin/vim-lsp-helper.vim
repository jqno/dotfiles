function SetupLsp(name, ispresent, server_info)
    if (a:ispresent)
        call lsp#register_server(a:server_info)
        setlocal omnifunc=lsp#complete
    else
        echohl ErrorMsg
        echom '[LSP] ' . a:name .' is not installed.'
        echohl NONE
    endif
endfunction
