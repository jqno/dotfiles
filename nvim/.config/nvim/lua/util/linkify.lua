local This = {}

function This.linkify()
    local url = vim.fn.expand('<cWORD>')
    local shell_esc_url = vim.fn.shellescape(url)
    local regex_esc_url = vim.fn.escape(url, '/')

    local link = vim.fn.system('linkify.py ' .. shell_esc_url)

    local chomped = vim.fn.substitute(link, '\\n\\+$', '', '')
    local escaped = vim.fn.substitute(chomped, '&', '\\\\&', '')
    local replaced = vim.fn.substitute(vim.fn.getline('.'), regex_esc_url, escaped, '')

    vim.fn.setline('.', replaced)
end

return This
