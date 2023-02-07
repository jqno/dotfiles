vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    group = vim.api.nvim_create_augroup('FileTypeWorksheetSc', {}),
    pattern = '*.worksheet.sc',
    callback = function() vim.opt.filetype = 'scala' end
})
