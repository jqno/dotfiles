local This = {}

local filetypes = { 'asciidoc', 'xml', 'lua', 'java', 'markdown', 'python', 'fugitiveblame' }

local function configure_filetypes()
    vim.api.nvim_create_augroup('configure_filetypes', { clear = true })
    for _, ft in pairs(filetypes) do
        vim.api.nvim_create_autocmd('FileType', {
            group = 'configure_filetypes',
            pattern = ft,
            callback = require('filetypes.' .. ft).setup
        })
    end
end

local function recognise_filetypes()
    vim.api.nvim_create_augroup('recognise_filetypes', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
        group = 'recognise_filetypes',
        pattern = 'pom.xml',
        callback = function() vim.opt.filetype = 'xml.pom' end
    })
    vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
        group = 'recognise_filetypes',
        pattern = '*.worksheet.sc',
        callback = function() vim.opt.filetype = 'scala' end
    })
end

function This.setup()
    configure_filetypes()
    recognise_filetypes()
end

return This
