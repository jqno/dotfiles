local This = {}

function This.setup()
    -- prevent silly shift-pressing mistakes
    vim.cmd([[
        command! -bang -nargs=* -complete=file E e<bang> <args>
        command! -bang -nargs=* -complete=file W w<bang> <args>
        command! -bang -nargs=* -complete=file Wq wq<bang> <args>
        command! -bang -nargs=* -complete=file WQ wq<bang> <args>
        command! -bang Wa wa<bang>
        command! -bang WA wa<bang>
        command! -bang Q q<bang>
        command! -bang QA qa<bang>
        command! -bang Qa qa<bang>
    ]])

    -- plugin management
    vim.cmd([[
        command! PlugLock execute 'PlugSnapshot! ' . g:plugin_lockfile
        command! PlugRevert execute 'source ' . g:plugin_lockfile
    ]])
end

return This
