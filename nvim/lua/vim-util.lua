local M = {}

function M.map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.buf_map(bufnr, mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
end

function M.augroup(group, cmd)
  vim.api.nvim_exec([[
    augroup ]] .. group .. [[
      autocmd!
      ]] .. cmd .. [[
    augroup END
  ]], false)
end

function M.highlight(group, fg, bg, gui)
  local cmd = 'highlight ' .. group
  if fg ~= nil then cmd = cmd .. ' guifg=' .. fg end
  if bg ~= nil then cmd = cmd .. ' guibg=' .. bg end
  if gui ~= nil then cmd = cmd .. ' gui=' .. gui end
  vim.cmd(cmd)
end

function M.highlight_link(group, link)
  local cmd = string.format('highlight link %s %s', group, link)
  vim.cmd(cmd)
end

return M
