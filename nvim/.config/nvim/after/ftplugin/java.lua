local map = vim.keymap.set
local mappings = require('config.mappings')
local modes = require('util.modes')
local jdtls = require('jdtls')
local terminal = require('util.terminal')

vim.opt_local.formatoptions:remove('o')
vim.opt_local.commentstring = '// %s'

map(modes.n, '<leader>gs', jdtls.super_implementation, { buffer = true, desc = 'go to super implementation' })

map(modes.n, '<leader>rR', function() jdtls.code_action(false, 'refactor') end,
    { buffer = true, desc = 'refactor: menu' })
map(modes.n, '<leader>rm', jdtls.extract_method, { buffer = true, desc = 'refactor: extract method' })
map(modes.v, '<leader>rm', function() jdtls.extract_method({ visual = true }) end,
    { buffer = true, desc = 'refactor: extract method' })
map(modes.n, '<leader>ro', jdtls.organize_imports, { buffer = true, desc = 'refactor: organize imports' })
map(modes.n, '<leader>rv', jdtls.extract_variable, { buffer = true, desc = 'refactor: extract variable' })
map(modes.v, '<leader>rv', function() jdtls.extract_variable({ visual = true }) end,
    { buffer = true, desc = 'refactor: extract variable' })
map(modes.n, '<leader>rV', jdtls.extract_variable_all,
    { buffer = true, desc = 'refactor: extract variable (all occurrences)' })

map(modes.n, '<leader>m<space>', function() terminal.send('runjava ' .. vim.fn.expand('%:p') .. '') end,
    { buffer = true, desc = 'run Java program' })
map(modes.n, '<leader>me',
    function()
        terminal.send(
            'mvn compile exec:java -Dexec.mainClass="' ..
            require('util.java').get_class() .. '"')
    end, { buffer = true, desc = 'mvn exec:java' })
map(modes.n, '<leader>mr', function() jdtls.update_project_config() end,
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
map(modes.n, '<leader>mx', require('jdtls').test_nearest_method, { buffer = true, desc = 'debug test nearest method' })
map(modes.n, '<leader>mX', require('jdtls').test_class, { buffer = true, desc = 'debug test class' })
mappings.setup_dap(vim.api.nvim_get_current_buf())


-- var keyword: Treesitter matches correctly as @type.builtin.java,
-- but LSP matches incorrectly as a regular type. LSP has higher priority
-- so Treesitter's match is overruled. This attempts to fix that (badly)
-- by matching a regex and give it an even higher priority.
vim.fn.matchadd("@keyword", "\\<var\\>", 150)
