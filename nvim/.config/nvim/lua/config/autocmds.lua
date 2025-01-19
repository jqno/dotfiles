local This = {}

function This.setup()
    -- Lead multi space
    local leadmultispace = vim.api.nvim_create_augroup('lead_multi_space', { clear = true })
    vim.api.nvim_create_autocmd('OptionSet', {
        group = leadmultispace,
        pattern = { 'listchars', 'tabstop', 'filetype' },
        callback = require('util.indent').set_leadmultispace
    })
    vim.api.nvim_create_autocmd('VimEnter', {
        group = leadmultispace,
        callback = require('util.indent').set_leadmultispace,
        once = true
    })

    -- Highlight on yank
    vim.api.nvim_create_autocmd('TextYankPost', {
        group = vim.api.nvim_create_augroup('highlight_on_yank', { clear = true }),
        pattern = '*',
        callback = function()
            vim.highlight.on_yank {
                higroup = 'IncSearch',
                timeout = 150,
                on_visual = true
            }
        end
    })
end

return This
