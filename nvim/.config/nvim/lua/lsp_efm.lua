local This = {}

This.filetypes = { 'java', 'lua', 'markdown', 'sh' }

local lint = {
  markdownlint = {
    lintCommand = 'markdownlint --stdin',
    lintStdin = true,
    lintIgnoreExitCode = true,
    lintFormats = { '%f:%l:%c %m', '%f:%l %m', '%f: %l: %m' }
  },
  shellcheck = {
    lintCommand = 'shellcheck -f gcc -x',
    lintSource = 'shellcheck',
    lintFormats = { '%f:%l:%c: %trror: %m', '%f:%l:%c: %tarning: %m', '%f:%l:%c: %tote: %m' }
  },
  vale = {
    lintCommand = 'vale --relative --output line ${INPUT}',
    lintStdin = false,
    lintIgnoreExitCode = true,
    lintFormats = { '%f:%l:%c:%*[^:]:%m' }
  }
}

local format = {
  luaformat = {
    formatCommand = 'lua-format -i',
    formatStdin = true
  },
  prettier = {
    formatCommand = 'prettier --stdin-filepath ${INPUT}',
    formatStdin = true
  }
}

This.settings = {
  rootMarkers = { '.git/' },
  languages = {
    java = { format.prettier },
    lua = { format.luaformat },
    markdown = { lint.markdownlint, lint.vale, format.prettier },
    sh = { lint.shellcheck }
  }
}

return This
