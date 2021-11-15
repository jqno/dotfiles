local This = {}

local cmp = require('cmp')

local function feedkey(key, mode)
    local keys = vim.api.nvim_replace_termcodes(key, true, true, true)
    vim.api.nvim_feedkeys(keys, mode, true)
end

local function has_words_before()
    if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
        return false
    end
    local line_nr, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_buf_get_lines(0, line_nr - 1, line_nr, true)[1]
    return col ~= 0 and line:sub(col, col):match('%s') == nil
end

local function tab_complete(fallback)
    if vim.fn.pumvisible() == 1 then
        feedkey('<C-n>', 'n')
    elseif vim.g.did_plugin_ultisnips and vim.fn['UltiSnips#CanJumpForwards']() ==
        1 then
        feedkey('<C-R>=UltiSnips#JumpForwards()<CR>', 'n')
    elseif has_words_before() then
        cmp.complete()
    else
        fallback()
    end
end

local function s_tab_complete(fallback)
    if vim.fn.pumvisible() == 1 then
        feedkey('<C-p>', 'n')
    elseif vim.g.did_plugin_ultisnips and vim.fn['UltiSnips#CanJumpBackwards']() ==
        1 then
        feedkey('<C-R>=UltiSnips#JumpBackwards()<CR>', 'n')
    else
        fallback()
    end
end

function This.setup()
    cmp.setup({
        completion = {
            completeopt = 'menu,menuone,noinsert,preview',
            autocomplete = false
        },
        snippet = {
            expand = function(args)
                vim.fn['UltiSnips#Anon'](args.body)
            end
        },
        mapping = {
            ['<Tab>'] = cmp.mapping(tab_complete, {'i', 's'}),
            ['<S-Tab>'] = cmp.mapping(s_tab_complete, {'i', 's'}),
            ['<Esc>'] = cmp.mapping.close(),
            ['<CR>'] = cmp.mapping.confirm({select = true})
        },
        sources = {
            {name = 'ultisnips'}, {name = 'nvim_lsp'}, {name = 'path'},
            {name = 'buffer'}
        },
        formatting = {
            format = function(entry, vim_item)
                vim_item.menu = ({
                    buffer = '[Buffer]',
                    nvim_lsp = '[LSP]',
                    path = 'Path',
                    ultisnips = '[UltiSnips]'
                })[entry.source.name]
                return vim_item
            end
        }
    })
end

return This
