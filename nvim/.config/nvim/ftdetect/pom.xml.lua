vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    group = vim.api.nvim_create_augroup('FileTypePomXml', {}),
    pattern = 'pom.xml',
    callback = function() vim.opt.filetype = 'xml.pom' end
})
