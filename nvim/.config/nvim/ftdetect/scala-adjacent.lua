vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    group = vim.api.nvim_create_augroup('FileTypeScalaAdjacent', {}),
    pattern = { '*.worksheet.sc', '*.sbt' },
    callback = function() vim.opt.filetype = 'scala' end
})
