local This = {}

This.markdownlint = {
  lintCommand = 'markdownlint -s',
  lintStdin = true,
  lintFormats = { '%f:%l %m', '%f:%l:%c %m', '%f: %l: %m' }
}

This.prettier = {
  formatCommand = 'prettier --stdin-filepath ${INPUT}',
  formatStdin = true
}

return This
