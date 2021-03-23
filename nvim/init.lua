
-- HELPERS --
local function opt(scope, key, value)
  scope[key] = value
  if scope ~= vim.o then vim.o[key] = value end
end

-- OPTIONS --
local indent = 2
opt(vim.bo, 'expandtab', true)
opt(vim.bo, 'tabstop', indent)
opt(vim.bo, 'shiftwidth', indent)
opt(vim.bo, 'softtabstop', indent)
