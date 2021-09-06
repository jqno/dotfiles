local This = {}

This.lint = {
  markdownlint = {
    lintCommand = 'markdownlint --stdin',
    lintStdin = true,
    lintFormats = { '%f:%l:%c %m', '%f:%l %m', '%f: %l: %m' }
  },
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
