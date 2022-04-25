local This = {}

local vim_util = require('vim-util')

This.do_autoformat = true

function This.setup()
    vim_util.augroup('format_on_save', 'BufWritePre', '*.java,*.lua', require('autoformat').format)

    vim.api.nvim_create_user_command('EnableAutoformat', function() require('autoformat').do_autoformat = true end, {})
    vim.api.nvim_create_user_command('DisableAutoformat', function() require('autoformat').do_autoformat = false end, {})
end

function This.format()
    if This.do_autoformat then
        vim.lsp.buf.formatting_sync()
    end
end

return This
