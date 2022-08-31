local This = {}

This.filetypes = { 'asciidoc', 'java', 'markdown' }

local lint = {
    markdownlint = {
        lintCommand = 'markdownlint --stdin',
        lintStdin = true,
        lintIgnoreExitCode = true,
        lintFormats = { '%f:%l:%c %m', '%f:%l %m', '%f: %l: %m' }
    },
    vale = {
        lintCommand = 'vale --output line ${INPUT}',
        lintStdin = false,
        lintIgnoreExitCode = true,
        lintFormats = { '%f:%l:%c:%t%*[^:]:%m' },
        lintCategoryMap = {
            a = 'I', -- alex
            p = 'W' -- proselint
        }
    }
}

local format = {
    prettier = {
        formatCommand = 'prettier --stdin-filepath ${INPUT}',
        formatStdin = true
    }
}

This.settings = {
    languages = {
        asciidoc = { lint.vale },
        java = { format.prettier },
        markdown = { lint.markdownlint, lint.vale, format.prettier }
    }
}

return This
