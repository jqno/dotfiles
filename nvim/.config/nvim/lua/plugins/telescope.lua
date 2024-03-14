return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons'
    },
    cmd = 'Telescope',

    config = function()
        local telescope = require('telescope')
        local actions = require('telescope.actions')
        local letters = {
            a = '🇦',
            b = '🇧',
            c = '🇨',
            d = '🇩',
            e = '🇪',
            f = '🇫',
            g = '🇬',
            h = '🇭',
            i = '🇮',
            j = '🇯',
            k = '🇰',
            l = '🇱',
            m = '🇲',
            n = '🇳',
            o = '🇴',
            p = '🇵',
            q = '🇶',
            r = '🇷',
            s = '🇸',
            t = '🇹',
            u = '🇺',
            v = '🇻',
            w = '🇼',
            x = '🇽',
            y = '🇾',
            z = '🇿'
        }
        local space = '/'

        local function path_subster(path)
            local replacement = ''
            local lang = path:match('src/main/(%a)%a*/')
            if lang ~= nil then
                replacement = letters.s .. space .. letters.m .. space .. letters[lang]
            else
                lang = path:match('src/test/(%a)%a*/')
                if lang ~= nil then
                    replacement = letters.s .. space .. letters.t .. space .. letters[lang]
                end
            end
            return path:gsub('src/(%a*)/(%a*)', replacement)
        end

        -- Adapted from https://github.com/nvim-telescope/telescope.nvim/issues/514#issuecomment-888356954
        local function entry_maker(entry)
            local entry_display = require('telescope.pickers.entry_display')
            local filename = entry.filename or vim.api.nvim_buf_get_name(entry.bufnr)

            local displayer = entry_display.create {
                separator = ' ',
                items = {
                    { width = 4 },
                    { width = 40 },
                    { remaining = true },
                },
            }

            local make_display = function(e)
                return displayer {
                    e.lnum,
                    vim.fn.fnamemodify(filename, ':t'),
                    e.text:gsub('^%s*(.*)%s*$', '%1'),
                }
            end

            return {
                valid = true,
                value = entry,
                ordinal = filename .. ' ' .. entry.text,
                display = make_display,
                bufnr = entry.bufnr,
                filename = filename,
                lnum = entry.lnum,
                col = entry.col,
                text = entry.text,
                start = entry.start,
                finish = entry.finish,
            }
        end

        telescope.setup({
            defaults = {
                vimgrep_arguments = {
                    'rg', '--color=never', '--no-heading', '--with-filename',
                    '--line-number', '--column', '--smart-case', '--hidden'
                },
                mappings = {
                    i = {
                        ['<Space>'] = actions.select_horizontal,
                        ['<C-CR>'] = actions.select_horizontal,
                        ['<C-L>'] = actions.select_vertical,
                        ['<Esc>'] = actions.close
                    }
                },
                layout_strategy = 'vertical',
                prompt_prefix = '❯ ',
                selection_caret = '❯ ',
                path_display = function(_, path)
                    return path_subster(path)
                end
            },
            pickers = {
                lsp_references = {
                    entry_maker = entry_maker
                    -- show_line = false
                }
            },
            extensions = {
                ['ui-select'] = { require('telescope.themes').get_dropdown() }
            }
        })
    end
}
