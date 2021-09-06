local This = {}

This.lint = {
  markdownlint = {
    lintCommand = 'markdownlint -s',
    lintStdin = true,
    lintFormats = { '%f:%l %m', '%f:%l:%c %m', '%f: %l: %m' }
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
