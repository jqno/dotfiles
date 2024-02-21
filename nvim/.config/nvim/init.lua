require('config.settings').setup()
require('config.lazy').setup()
require('config.mappings').setup()
require('config.commands').setup()

-- Optionally require ~/.nvim-local.lua
local local_conf = vim.env.HOME .. '/.nvim-local.lua'
if vim.fn.filereadable(local_conf) == 1 then
    vim.cmd('luafile ' .. local_conf)
end
