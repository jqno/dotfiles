return {
    'hrsh7th/nvim-cmp',
    lazy = true,
    dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-emoji',
        'saadparwaiz1/cmp_luasnip'
    },

    config = function()
        local cmp = require('cmp')
        local ELLIPSIS = '…'
        local MAX_WIDTH = 60

        local function has_words_before()
            if vim.api.nvim_get_option_value('buftype', { buf = 0 }) == 'prompt' then
                return false
            end
            local line_nr, col = unpack(vim.api.nvim_win_get_cursor(0))
            local line = vim.api.nvim_buf_get_lines(0, line_nr - 1, line_nr, true)[1]
            return col ~= 0 and line:sub(col, col):match('%s') == nil
        end

        local function tab_complete(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif has_words_before() then
                cmp.complete({ reason = cmp.ContextReason.Auto })
            else
                fallback()
            end
        end

        local function s_tab_complete(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end

        cmp.setup({
            completion = {
                completeopt = 'menu,menuone,noinsert,preview',
                autocomplete = false
            },
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered()
            },
            mapping = {
                ['<Tab>'] = cmp.mapping(tab_complete, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(s_tab_complete, { 'i', 's' }),
                ['<Down>'] = cmp.mapping.select_next_item(),
                ['<Up>'] = cmp.mapping.select_prev_item(),
                ['<Esc>'] = cmp.mapping.close(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<C-D>'] = cmp.mapping.scroll_docs(4),
                ['<C-U>'] = cmp.mapping.scroll_docs(-4)
            },
            sources = {
                { name = 'luasnip' },
                { name = 'nvim_lsp' },
                { name = 'emoji' },
                { name = 'path' },
                { name = 'buffer' },
                { name = 'lazydev', group_index = 0 }
            },
            formatting = {
                format = function(entry, vim_item)
                    vim_item.menu = ({
                        buffer = '[Buffer]',
                        nvim_lsp = '[LSP]',
                        path = '[Path]',
                        luasnip = '[Snip]'
                    })[entry.source.name]
                    if #vim_item.abbr > MAX_WIDTH then
                        vim_item.abbr = vim.fn.strcharpart(vim_item.abbr, 0, MAX_WIDTH) .. ELLIPSIS
                    end
                    return vim_item
                end
            },
            experimental = {
                ghost_text = {
                    hl_group = 'Conceal'
                }
            }
        })
    end
}
