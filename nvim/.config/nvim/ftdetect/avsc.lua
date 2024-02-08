vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    group = vim.api.nvim_create_augroup('FileTypeAvro', {}),
    pattern = { '*.avsc' },
    callback = function() vim.opt.filetype = 'json' end
})
