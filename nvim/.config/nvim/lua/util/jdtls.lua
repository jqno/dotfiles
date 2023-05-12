local This = {}

local function find_project_root()
    if vim.g.jdtls_project_root ~= nil then
        return vim.g.jdtls_project_root
    end

    -- always assume a git project; this works better with multimodule projects
    return require('jdtls.setup').find_root({ '.git' })
end

function This.jdtls_config(capabilities)
    local location = vim.fn.stdpath('data') .. '/mason/packages/jdtls'
    local jdtls_bundles = {
        vim.fn.glob(
            '~/bin/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar')
    }
    vim.list_extend(jdtls_bundles, vim.split(
        vim.fn.glob('~/bin/vscode-java-test/server/*.jar'), '\n'))

    return {
        cmd = {
            'jdtls.sh',
            location .. '/bin',
            location,
            vim.env.HOME .. '/.vim/jdtls/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
        },
        init_options = { bundles = jdtls_bundles },
        root_dir = find_project_root(),
        capabilities = capabilities,
        handlers = {
            -- To avoid annoying 'Press Enter to continue' messages while downloading dependencies
            ['language/status'] = function(_, result)
                local msg = result.message
                local c = vim.o.columns
                if #msg > c then
                    msg = msg:sub(1, c - 1) .. '…'
                end
                vim.cmd.echo('"' .. msg .. '"')
            end
        },
        settings = {
            java = {
                use_lombok_agent = true,
                format = { enabled = false },
                signatureHelp = { enabled = true },
                codeGeneration = {
                    hashCodeEquals = {
                        useInstanceof = true,
                        useJava7Objects = true
                    },
                    useBlocks = true
                },
                completion = {
                    favoriteStaticMembers = {
                        'io.restassured.RestAssured.*',
                        'java.util.Objects.requireNonNull',
                        'java.util.Objects.requireNonNullElse',
                        'org.hamcrest.CoreMatchers.*',
                        'org.hamcrest.Matchers.*',
                        'org.junit.jupiter.api.Assertions.*',
                        'org.mockito.Mockito.*'
                    },
                    filteredTypes = {
                        'com.sun.*',
                        'java.awt.*',
                        'jdk.*',
                        'sun.*',
                        'antlr.collections.List',
                        'org.hibernate.mapping.List'
                    },
                    importOrder = { 'com', 'info', 'io', 'jakarta', 'net', 'nl', 'org', 'javax', 'java' }
                }
            }
        }
    }
end

return This
