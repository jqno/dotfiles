-- Inspired by https://github.com/jeffkreeftmeijer/vim-numbertoggle

local M = {}

local enabled = true

function M.toggle()
    enabled = not enabled
    vim.wo.relativenumber = enabled and vim.wo.number and vim.api.nvim_get_mode().mode ~= 'i'
end

function M.setup()
    local group = vim.api.nvim_create_augroup('numbertoggle', { clear = true })

    vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter' }, {
        group = group,
        pattern = '*',
        callback = function()
            vim.wo.relativenumber = enabled and vim.wo.number and vim.api.nvim_get_mode().mode ~= 'i'
        end,
    })

    vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave' }, {
        group = group,
        pattern = '*',
        callback = function()
            vim.wo.relativenumber = false
        end,
    })
end

return M
