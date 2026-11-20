local map = vim.keymap.set
local mappings = require('config.mappings')
local modes = require('util.modes')
local terminal = require('util.terminal')

vim.opt_local.formatoptions:remove('o')
vim.opt_local.commentstring = '// %s'

local function code_action(kind, title_filter)
    return function()
        vim.lsp.buf.code_action({
            context = { only = { kind } },
            filter = function(action) return title_filter(action.title) end,
            apply = true
        })
    end
end

local function replaces_all(title) return title:find('replace all', 1, true) ~= nil end
local function replaces_one(title) return not replaces_all(title) end

map(modes.n, '<leader>gs', vim.lsp.buf.declaration, { buffer = true, desc = 'go to super implementation' })

map(modes.n, '<leader>rR', function() vim.lsp.buf.code_action({ context = { only = { 'refactor' } } }) end,
    { buffer = true, desc = 'refactor: menu' })
map({ modes.n, modes.v }, '<leader>rm', code_action('refactor.extract.method', replaces_one),
    { buffer = true, desc = 'refactor: extract method' })
map(modes.n, '<leader>ro', vim.cmd.LatheMissingImports, { buffer = true, desc = 'refactor: add missing imports' })
map({ modes.n, modes.v }, '<leader>rv', code_action('refactor.extract.variable', replaces_one),
    { buffer = true, desc = 'refactor: extract variable' })
map({ modes.n, modes.v }, '<leader>rV', code_action('refactor.extract.variable', replaces_all),
    { buffer = true, desc = 'refactor: extract variable (all occurrences)' })

map(modes.n, '<leader>m<space>', function() terminal.send('runjava ' .. vim.fn.expand('%:p') .. '') end,
    { buffer = true, desc = 'run Java program' })
map(modes.n, '<leader>me',
    function()
        terminal.send(
            'mvn compile exec:java -Dexec.mainClass="' ..
            require('util.java').get_class() .. '"')
    end, { buffer = true, desc = 'mvn exec:java' })
map(modes.n, '<leader>mr', vim.cmd.LatheSync,
    { buffer = true, desc = 'reload build configuration' })
map(modes.n, '<leader>mcc', function() terminal.send('mvn clean test-compile') end,
    { buffer = true, desc = 'mvn clean compile' })
map(modes.n, '<leader>mcv', function() terminal.send('mvn clean verify') end,
    { buffer = true, desc = 'mvn clean verify' })
map(modes.n, '<leader>mp', function() terminal.send('mvn clean package -DskipTests=true') end,
    { buffer = true, desc = 'mvn package (no tests)' })
map(modes.n, '<leader>mv', function() terminal.send('mvn verify') end, { buffer = true, desc = 'mvn verify' })

map(modes.n, '<leader>tq', require('util.java').toggle_maven_quiet, { buffer = true, desc = 'toggle maven quiet' })


-- Debug
map(modes.n, '<leader>mx', vim.cmd.LatheDebug, { buffer = true, desc = 'debug test or main at cursor' })
mappings.setup_dap(vim.api.nvim_get_current_buf())


-- var keyword: Treesitter matches correctly as @type.builtin.java,
-- but LSP matches incorrectly as a regular type. LSP has higher priority
-- so Treesitter's match is overruled. This attempts to fix that (badly)
-- by matching a regex and give it an even higher priority.
vim.fn.matchadd("@keyword", "\\<var\\>", 150)
