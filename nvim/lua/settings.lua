-- HELPERS --
local function set(scope, key, value)
  scope[key] = value
  if scope ~= vim.o then vim.o[key] = value end
end

-- SETTINGS --
local indent = 2
set(vim.bo, 'expandtab', true)
set(vim.bo, 'tabstop', indent)
set(vim.bo, 'shiftwidth', indent)
set(vim.bo, 'softtabstop', indent)

set(vim.o, 'completeopt', 'menuone,noselect')
set(vim.o, 'updatetime', 300)
