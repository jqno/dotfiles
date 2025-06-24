local This = {}

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

function This.setup()
    -- Reload files when leaving terminal buffer
    -- Useful when running formatters or AI agents
    vim.api.nvim_create_autocmd("BufLeave", {
        pattern = "*",
        callback = function()
            if vim.bo.buftype == "terminal" then
                vim.cmd.checktime()
            end
        end,
    })

    -- Lead multi space
    local leadmultispace = augroup('lead_multi_space', { clear = true })
    autocmd('OptionSet', {
        group = leadmultispace,
        pattern = { 'listchars', 'tabstop', 'filetype' },
        callback = require('util.indent').set_leadmultispace
    })
    autocmd('VimEnter', {
        group = leadmultispace,
        callback = require('util.indent').set_leadmultispace,
        once = true
    })

    -- Highlight on yank
    autocmd('TextYankPost', {
        group = augroup('highlight_on_yank', { clear = true }),
        pattern = '*',
        callback = function()
            vim.highlight.on_yank {
                higroup = 'IncSearch',
                timeout = 150,
                on_visual = true
            }
        end
    })

    -- Window automations
    local window_automations = augroup('window_automations', { clear = true })
    -- Auto-resize splits when terminal window resizes
    autocmd("VimResized", {
        group = window_automations,
        command = "wincmd =",
    })
    -- Open help on the right if in vertical mode
    local orientation = require('util.screen-orientation')
    if orientation.get_orientation() == orientation.LANDSCAPE then
        autocmd("FileType", {
            group = window_automations,
            pattern = "help",
            command = "wincmd L",
        })
    end

    -- Clear search
    autocmd({ "InsertEnter", "CmdlineEnter" }, {
        group = augroup('clear_search_when_entering_insert_mode', { clear = true }),
        callback = vim.schedule_wrap(function() vim.cmd.nohlsearch() end),
    })
end

return This
