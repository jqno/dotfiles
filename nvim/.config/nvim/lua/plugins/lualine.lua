return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'linrongbin16/lsp-progress.nvim'
    },

    config = function()
        local function empty(n)
            return function()
                return string.rep(' ', n)
            end
        end

        local function mode_fmt(s)
            local ch = s:sub(1, 1)
            if ch == 'N' then
                return ''
            elseif ch == 'V' then
                return ''
            else
                return ch
            end
        end

        local filename = {
            'filename',
            path = 0,
            symbols = { modified = '+', readonly = '🔒', unnamed = ' ⊥ ', newfile = ' ⊥ ' },
            fmt = function(s)
                if s:match('NvimTree') then
                    return ' 󱏒 '
                elseif s:match('quickfix') then
                    return 'Quickfix'
                else
                    return s
                end
            end
        }

        local function git_status()
            local gsd = vim.b.gitsigns_status_dict
            if gsd and (gsd.added ~= 0 or gsd.changed ~= 0 or gsd.removed ~= 0) then
                return '•'
            end
            return ''
        end

        local function window_status()
            if require('util.toggle-zoom').is_zoomed() then
                return ' '
            else
                return ''
            end
        end

        local function grapple()
            local g = require('grapple')
            if g.exists() then
                return '󰛢' .. g.name_or_index()
            else
                return ''
            end
        end

        local function autoformat()
            local bufnr = vim.fn.bufnr()
            if vim.g.do_autoformat or vim.b[bufnr].do_autoformat then
                if require('util.is-editable').is_editable(bufnr) then
                    return '󰁨'
                end
            end
            return ''
        end

        local function word_count()
            if vim.bo.filetype == 'markdown' then
                return '󰈭 ' .. vim.fn.wordcount().words
            end
            return ''
        end

        local function intelligence_status()
            local result = ''
            local ft = vim.bo.filetype

            -- LSP
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            if not vim.tbl_isempty(clients) then
                result = result .. '󰌵 '
            end

            -- Lint
            if require('lint').linters_by_ft[ft] ~= nil then
                result = result .. ' '
            end

            -- Formatter
            if require('conform').formatters_by_ft[ft] ~= nil then
                result = result .. '󰃢 '
            end

            return result
        end

        local diag = require('util.icons')
        local diagnostics = {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            sections = { 'error', 'warn' },
            symbols = { error = diag.error, warn = diag.warn, info = diag.info, hint = diag.hint }
        }

        local fileformat = {
            'fileformat',
            symbols = { unix = '' }
        }

        local encoding = {
            'encoding',
            show_bomb = true,
            fmt = function(s)
                if s == 'utf-8' then
                    return ''
                else
                    return s
                end
            end
        }

        local function progress()
            local indicators = { ' ', '▔', '🮂', '🮃', '▀', '🮄', '🮅', '🮆', '█' }
            local line = vim.fn.line('.')
            local col = vim.fn.col('.')
            local total = vim.fn.line('$')
            local indicator = ' '
            if total > 1 and line > 1 then
                local idx = math.floor(line / total * (#indicators - 1))
                indicator = indicators[idx + 1]
            end
            return line .. ':' .. col .. ' ' .. indicator
        end

        local lsp_status = {
            function() return require('lsp-progress').progress() end,
            color = 'Keyword'
        }

        require('lsp-progress').setup({
            spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
            -- All this to make it look nice
            client_format = function(client_name, spinner, series_messages)
                if #series_messages > 0 then
                    local max_len = math.floor(vim.api.nvim_win_get_width(0) / 3)
                    local s = table.concat(series_messages, ', ')
                    if #s > max_len then
                        local left_len = math.floor((max_len - 1) / 2)
                        local right_len = max_len - left_len - 1
                        s = s:sub(1, left_len) .. '…' .. s:sub(-right_len)
                    end
                    return (s .. ' ' .. spinner .. ' ' .. '[' .. client_name .. ']')
                end
                return nil
            end,
            -- Prevent a permanent message; I prefer to have the one from intelligence_status
            format = function(client_messages) return table.concat(client_messages, ' ') end
        })

        require('lualine').setup({
            options = {
                component_separators = '',
                section_separators = { left = '', right = '' },
                theme = 'tranquility'
            },
            sections = {
                lualine_a = { { 'mode', fmt = mode_fmt } },
                lualine_b = { filename, { git_status, padding = { left = 0 } }, window_status },
                lualine_c = { grapple, autoformat },
                lualine_x = { word_count, lsp_status, diagnostics, intelligence_status },
                lualine_y = { 'filetype', fileformat, encoding },
                lualine_z = { progress }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { empty(2), filename, git_status, window_status },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {}
            },
            extensions = {
                {
                    sections = {
                        lualine_a = { empty(4), filename }
                    },
                    filetypes = { 'qf', 'NvimTree' }
                }
            }
        })

        vim.api.nvim_create_augroup('lualine_augroup', { clear = true })
        vim.api.nvim_create_autocmd('User', {
            group = 'lualine_augroup',
            pattern = 'LspProgressStatusUpdated',
            callback = require('lualine').refresh,
        })
    end
}
