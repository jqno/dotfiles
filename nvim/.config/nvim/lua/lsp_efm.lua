local This = {}

This.lint = {
  markdownlint = {
    lintCommand = 'markdownlint --stdin',
    lintStdin = true,
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

This.format = {
  luaformat = {
    formatCommand = 'lua-format -i',
    formatStdin = true
  },
  prettier = {
    formatCommand = 'prettier --stdin-filepath ${INPUT}',
    formatStdin = true
  }
}

return This
