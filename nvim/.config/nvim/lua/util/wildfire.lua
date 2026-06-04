local This = {}

local This = {}

local function run_or_passthrough(key, ts_action, lsp_count)
    if vim.bo.buftype ~= "" then
        vim.api.nvim_feedkeys(vim.keycode(key), "n", false)
        return
    end
    if vim.treesitter.get_parser(nil, nil, { error = false }) then
        ts_action(vim.v.count1)
    else
        vim.lsp.buf.selection_range(lsp_count)
    end
end

function This.expand(key)
    run_or_passthrough(key, require('vim.treesitter._select').select_parent, vim.v.count1)
end

function This.contract(key)
    run_or_passthrough(key, require('vim.treesitter._select').select_child, -vim.v.count1)
end

return This
