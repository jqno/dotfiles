local This = {}

local function close_windows_matching(condition)
    local windows = vim.api.nvim_list_wins()
    for _, win in ipairs(windows) do
        local buf = vim.api.nvim_win_get_buf(win)

        local close =
            (condition.ft ~= nil and
                condition.ft == vim.api.nvim_buf_get_option(buf, 'filetype')
            )
            or
            (condition.name ~= nil and
                vim.api.nvim_buf_get_name(buf):match(condition.name) ~= nil
            )

        if close then
            vim.api.nvim_win_close(win, false)
        end
    end
end

function This.close_everything()
    vim.cmd.pclose()
    vim.cmd.cclose()
    vim.cmd.lclose()
    vim.cmd.NvimTreeClose()
    vim.cmd.FloatermHide()
    vim.cmd.UndotreeHide()
    vim.cmd.OutlineClose()

    require('dap').repl.close()

    close_windows_matching({ ft = 'help' })
    close_windows_matching({ ft = 'outputpanel' })
    close_windows_matching({ name = 'gen.nvim' })
end

return This
