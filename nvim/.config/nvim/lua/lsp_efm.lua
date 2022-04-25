local This = {}

This.filetypes = {'asciidoc', 'java', 'markdown', 'sh'}

local lint = {
    markdownlint = {
        lintCommand = 'markdownlint --stdin',
        lintStdin = true,
        lintIgnoreExitCode = true,
        lintFormats = {'%f:%l:%c %m', '%f:%l %m', '%f: %l: %m'}
    },
    shellcheck = {
        lintCommand = 'shellcheck -f gcc -x',
        lintSource = 'shellcheck',
        lintFormats = {
            '%f:%l:%c: %trror: %m', '%f:%l:%c: %tarning: %m',
            '%f:%l:%c: %tote: %m'
        }
    },
    vale = {
        lintCommand = 'vale --output line ${INPUT}',
        lintStdin = false,
        lintIgnoreExitCode = true,
        lintFormats = {'%f:%l:%c:%*[^:]:%m'}
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
        asciidoc = {lint.vale},
        java = {format.prettier},
        markdown = {lint.markdownlint, lint.vale, format.prettier},
        sh = {lint.shellcheck}
    }
}

return This
