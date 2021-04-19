M = {}

function M.close_everything()
  vim.api.nvim_command('pclose')
  vim.api.nvim_command('cclose')
  vim.api.nvim_command('NvimTreeClose')
  require('dap').repl.close()
end

return M
