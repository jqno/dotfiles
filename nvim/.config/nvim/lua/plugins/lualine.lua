return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'AndreM222/copilot-lualine'
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

        local function metals_status()
            if vim.g.metals_status then
                return ' ' .. vim.g.metals_status .. ' '
            else
                return ''
            end
        end

        local copilot = {
            'copilot',
            symbols = {
                status = {
                    icons = {
                        enabled = "",
                        sleep = "",
                        disabled = "",
                        warning = "",
                        unknown = ""
                    }
                }
            }
        }

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
                lualine_x = { word_count, metals_status, diagnostics, copilot, intelligence_status },
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
    end
}
