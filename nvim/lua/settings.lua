local This = {}

local set = require('vim-util').set

-- HELPERS --
local default_indent = 2

function This.set_buf_indent(indent)
  if indent == nil then
    -- tab
    vim.bo.expandtab = false
    vim.bo.shiftwidth = 8
    vim.bo.softtabstop = 8
    vim.bo.tabstop = 8
  else
    -- spaces
    vim.bo.expandtab = true
    vim.bo.shiftwidth = indent
    vim.bo.softtabstop = indent
    vim.bo.tabstop = indent
  end
end

-- SETTINGS --
function This.setup()
  set(vim.bo, 'expandtab', true)
  set(vim.bo, 'shiftwidth', default_indent)
  set(vim.bo, 'softtabstop', default_indent)
  set(vim.bo, 'tabstop', default_indent)

  set(vim.wo, 'linebreak', true)
  set(vim.wo, 'number', true)
  set(vim.wo, 'relativenumber', true)
  set(vim.wo, 'scrolloff', 1)
  set(vim.wo, 'sidescrolloff', 5)
  set(vim.wo, 'signcolumn', 'yes')
  set(vim.wo, 'wrap', false)

  set(vim.o, 'completeopt', 'menuone,noselect,preview')
  set(vim.o, 'ignorecase', true)
  set(vim.o, 'joinspaces', false)
  set(vim.o, 'shiftround', true)
  set(vim.o, 'showmode', false)
  set(vim.o, 'smartcase', true)
  set(vim.o, 'termguicolors', true)
  set(vim.o, 'title', true)
  set(vim.o, 'titlestring', '%t - nvim')
  set(vim.o, 'updatetime', 300)
  vim.o.shortmess = string.gsub(vim.o.shortmess, 'F', '') .. 'c'
  vim.cmd('colorscheme onedark')
end

return This
