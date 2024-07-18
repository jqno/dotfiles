local map = vim.keymap.set
local modes = require('util.modes')
local jdtls = require('jdtls')
local floaterm = require('plugins.floaterm')

vim.opt_local.formatoptions:remove('o')
vim.opt_local.commentstring = '// %s'
require('util.indent').set_buf_indent(4, false)

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

map(modes.n, '<leader>m<space>', function() floaterm.send('jbang ' .. vim.fn.expand('%:p') .. '') end,
    { buffer = true, desc = 'run with JBang' })
map(modes.n, '<leader>me',
    function()
        floaterm.send(
            'mvn compile exec:java -Dexec.mainClass="' ..
            require('util.java').get_class() .. '"')
    end, { buffer = true, desc = 'mvn exec:java' })
map(modes.n, '<leader>mr', jdtls.update_project_config, { buffer = true, desc = 'reload build configuration' })
map(modes.n, '<leader>mcc', function() floaterm.send('mvnd clean test-compile') end,
    { buffer = true, desc = 'mvn clean compile' })
map(modes.n, '<leader>mcv', function() floaterm.send('mvnd clean verify') end,
    { buffer = true, desc = 'mvn clean verify' })
map(modes.n, '<leader>mp', function() floaterm.send('mvnd clean package -DskipTests=true') end,
    { buffer = true, desc = 'mvn package (no tests)' })
map(modes.n, '<leader>mv', function() floaterm.send('mvnd verify') end, { buffer = true, desc = 'mvn verify' })

vim.api.nvim_create_augroup('LspAttachJava', { clear = true })
vim.api.nvim_create_autocmd('LspAttach', {
    group = 'LspAttachJava',
    buffer = 0,
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client ~= nil and client.name == 'jdtls' then
            client.server_capabilities.documentFormattingProvider = false
        end
    end
})
