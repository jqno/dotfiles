local M = {}

function M.close_buffers(close_all)
    local current_bufnr = vim.api.nvim_get_current_buf()
    local bufs = vim.api.nvim_list_bufs()

    for _, bufnr in ipairs(bufs) do
        if vim.api.nvim_buf_is_valid(bufnr) then
            local is_modified = vim.bo[bufnr].modified
            local is_listed = vim.bo[bufnr].buflisted

            if (close_all or bufnr ~= current_bufnr) and not is_modified and is_listed then
                pcall(vim.api.nvim_buf_delete, bufnr, { force = false })
            end
        end
    end
    print('Closed buffers')
end

return M
