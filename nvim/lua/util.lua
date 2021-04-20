This = {}

function This.close_everything()
  vim.api.nvim_command('pclose')
  vim.api.nvim_command('cclose')
  vim.api.nvim_command('NvimTreeClose')
  require('dap').repl.close()
end

function This.linkify()
  local fn = vim.fn
  local url = fn.shellescape(fn.expand('<cWORD>'))
  local link = fn.system('linkify.py ' .. url)
  local chomped = fn.substitute(link, '\n+$', '', '')
  local prevchar = fn.strpart(fn.getline('.'), fn.col('.') - 2, 1)
  if prevchar == ' ' or prevchar == '' then
    vim.api.nvim_exec('norm cW' .. chomped, false)
  else
    vim.api.nvim_exec('norm BcW' .. chomped, false)
  end
end

return This
