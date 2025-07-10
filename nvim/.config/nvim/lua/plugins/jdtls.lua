local function jdtls_config(capabilities)
    local mason_path = vim.fn.stdpath('data') .. '/mason'
    local jdtls_path = mason_path .. '/packages/jdtls'

    local bundles = {
        vim.fn.glob(mason_path .. '/share/java-debug-adapter/*.jar', true),
    };
    vim.list_extend(bundles, vim.split(vim.fn.glob(mason_path .. '/share/nvim/mason/share/java-test/*.jar', true), '\n'))

    return {
        cmd = {
            'jdtls.sh',
            jdtls_path .. '/bin',
            jdtls_path,
            vim.env.HOME .. '/.vim/jdtls/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
        },
        root_dir = (function()
            if vim.g.jdtls_project_root ~= nil then
                return vim.g.jdtls_project_root
            end

            -- always assume a git project; this works better with multimodule projects
            return require('jdtls.setup').find_root({ '.git' })
        end)(),
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
        init_options = {
            bundles = bundles
        },
        settings = {
            java = {
                format = {
                    settings = {
                        url = vim.env.HOME .. '/.config/eclipse-formatter-config.xml'
                    }
                },
                inlayHints = {
                    parameterNames = {
                        enabled = "all"
                    }
                },
                implementationCodeLens = "all",
                use_lombok_agent = true,
                signatureHelp = { enabled = true },
                sources = {
                    organizeImports = {
                        starThreshold = 4,
                        staticStarThreshold = 4
                    }
                },
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
                        'org.assertj.core.api.Assertions.*',
                        'org.assertj.core.api.SoftAssertions.*',
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
                    importOrder = { '\\#', 'java', '' }
                }
            }
        }
    }
end

return {
    'mfussenegger/nvim-jdtls',
    ft = { 'java' },

    jdtls_config = jdtls_config
}
