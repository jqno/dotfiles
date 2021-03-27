-- HELPERS --
local function set(scope, key, value)
  scope[key] = value
  if scope ~= vim.o then vim.o[key] = value end
end

-- SETTINGS --
local indent = 2
set(vim.bo, 'expandtab', true)
set(vim.bo, 'shiftwidth', indent)
set(vim.bo, 'softtabstop', indent)
set(vim.bo, 'tabstop', indent)

set(vim.wo, 'number', true)
set(vim.wo, 'relativenumber', true)
set(vim.wo, 'signcolumn', 'yes')

set(vim.o, 'completeopt', 'menuone,noselect,preview')
set(vim.o, 'updatetime', 300)
vim.o.shortmess = string.gsub(vim.o.shortmess, 'F', '') .. 'c'
