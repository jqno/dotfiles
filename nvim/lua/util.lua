This = {}

local fn = vim.fn
local exec = vim.api.nvim_exec

function This.close_everything()
  vim.api.nvim_command('pclose')
  vim.api.nvim_command('cclose')
  vim.api.nvim_command('NvimTreeClose')
  require('dap').repl.close()
end

function This.linkify()
  local url = fn.shellescape(fn.expand('<cWORD>'))
  local link = fn.system('linkify.py ' .. url)
  local chomped = fn.substitute(link, '\n+$', '', '')
  local prevchar = fn.strpart(fn.getline('.'), fn.col('.') - 2, 1)
  if prevchar == ' ' or prevchar == '' then
    exec('norm cW' .. chomped, false)
  else
    exec('norm BcW' .. chomped, false)
  end
end

function This.set_buf_indent(indent, show)
  if indent == nil then
    -- tab
    vim.bo.expandtab = false
    vim.bo.shiftwidth = 8
    vim.bo.softtabstop = 8
    vim.bo.tabstop = 8
    if show then
      print('Indentation level: tab')
    end
  else
    -- spaces
    vim.bo.expandtab = true
    vim.bo.shiftwidth = indent
    vim.bo.softtabstop = indent
    vim.bo.tabstop = indent
    if show then
      print('Indentation level: ' .. indent)
    end
  end
end

function This.toggle_movement(firstOp, thenOp)
  -- Inspired by http://ddrscott.github.io/blog/2016/vim-toggle-movement/
  local pos1 = fn.getpos('.')
  exec('normal! ' .. firstOp, false)
  if vim.deep_equal(pos1, fn.getpos('.')) then
    exec('normal! ' .. thenOp, false)
  end
end

return This
