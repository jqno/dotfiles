require('util.indent').set_buf_indent(4, false)

local map = vim.keymap.set
local modes = require('util.modes')
local dap = require('dap')
local jdtls = require('jdtls')

local function dap_run_test()
    dap.repl.open()
    jdtls.test_class()
end

local function dap_run_test_nearest()
    dap.repl.open()
    jdtls.test_nearest_method()
end

map(modes.n, '<leader>dr', require('dap').continue, { buffer = true, desc = 'debug: run' })
map(modes.n, '<leader>dt', dap_run_test_nearest, { buffer = true, desc = 'debug: run nearest test' })
map(modes.n, '<leader>dT', dap_run_test, { buffer = true, desc = 'debug: test file' })

map(modes.n, '<leader>gs', require('jdtls').super_implementation, { buffer = true, desc = 'go to super implementation' })

map(modes.n, '<leader>rR', function() require('jdtls').code_action(false, 'refactor') end,
    { buffer = true, desc = 'refactor: menu' })
map(modes.n, '<leader>rm', require('jdtls').extract_method, { buffer = true, desc = 'refactor: extract method' })
map(modes.v, '<leader>rm', function() require('jdtls').extract_method(true) end,
    { buffer = true, desc = 'refactor: extract method' })
map(modes.n, '<leader>ro', require('jdtls').organize_imports, { buffer = true, desc = 'refactor: organize imports' })
map(modes.n, '<leader>rv', require('jdtls').extract_variable, { buffer = true, desc = 'refactor: extract variable' })
map(modes.v, '<leader>rv', function() require('jdtls').extract_variable(true) end,
    { buffer = true, desc = 'refactor: extract variable' })
map(modes.n, '<leader>rV', require('jdtls').extract_variable_all,
    { buffer = true, desc = 'refactor: extract variable (all occurrences)' })

local floaterm = require('util.floaterm')
map(modes.n, '<leader>m<space>', function() floaterm.floatermsend('jbang ' .. vim.fn.expand('%:p') .. '') end,
    { buffer = true, desc = 'run with JBang' })
map(modes.n, '<leader>mr', require('jdtls').update_project_config, { buffer = true, desc = 'reload build configuration' })
map(modes.n, '<leader>mcc', function() floaterm.floatermsend('mvnd clean test-compile') end,
    { buffer = true, desc = 'mvn clean compile' })
map(modes.n, '<leader>mcv', function() floaterm.floatermsend('mvnd clean verify') end,
    { buffer = true, desc = 'mvn clean verify' })
map(modes.n, '<leader>mp', function() floaterm.floatermsend('mvnd clean package -DskipTests=true') end,
    { buffer = true, desc = 'mvn package (no tests)' })
map(modes.n, '<leader>mv', function() floaterm.floatermsend('mvnd verify') end, { buffer = true, desc = 'mvn verify' })

vim.api.nvim_create_augroup('LspAttachJava', { clear = true })
vim.api.nvim_create_autocmd('LspAttach', {
    group = 'LspAttachJava',
    buffer = 0,
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client.name == 'jdtls' then
            require('jdtls.setup').add_commands()
            require('jdtls').setup_dap({ hotcodereplace = 'auto' })
            require('jdtls.dap').setup_dap_main_class_configs()
            require('config.mappings').setup_dap(bufnr)

            client.server_capabilities.documentFormattingProvider = false
        end
    end
})