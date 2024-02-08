vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    group = vim.api.nvim_create_augroup('FileTypeHocon', {}),
    pattern = { '*.conf' },
    callback = function() vim.opt.filetype = 'hocon' end
})
