return {
    'freddiehaddad/feline.nvim',
    dependencies = {
        'kyazdani42/nvim-web-devicons'
    },
    event = 'UIEnter',

    config = function()
        local diag = require('util.icons')

        local left_sep = ''
        local right_sep = ''

        local _vimode_text = {
            n = '',
            no = '',
            i = 'I',
            v = '',
            V = '',
            [''] = '',
            c = 'C',
            cv = 'C',
            ce = 'C',
            R = 'R',
            Rv = 'R',
            s = 'S',
            S = 'S',
            [''] = 'S',
            t = 'T',
        }

        local colors = {
            background = '#3b3b3b',
            black = '#252525',
            red = '#ed4a46',
            green = '#70b433',
            yellow = '#dbb32d',
            blue = '#368aeb',
            magenta = '#eb6eb7',
            cyan = '#56d8c9',
            white = '#dedede',
        }

        local highlights = {
            main = {
                fg = colors.black,
                bg = colors.white
            },
            secondary = {
                fg = colors.white,
                bg = colors.background
            },
            [''] = {
                fg = colors.black,
                bg = colors.green,
            },
            I = {
                fg = colors.black,
                bg = colors.yellow,
            },
            [''] = {
                fg = colors.black,
                bg = colors.blue,
            },
            C = {
                fg = colors.black,
                bg = colors.magenta,
            },
            R = {
                fg = colors.black,
                bg = colors.yellow,
            },
            S = {
                fg = colors.black,
                bg = colors.red,
            },
            T = {
                fg = colors.black,
                bg = colors.cyan,
            },
            error = {
                fg = colors.red,
                bg = colors.background
            },
            warn = {
                fg = colors.magenta,
                bg = colors.background
            },
            info = {
                fg = colors.cyan,
                bg = colors.background
            },
            hint = {
                fg = colors.white,
                bg = colors.background
            }
        }

        local function vimode_text()
            return _vimode_text[vim.fn.mode()]
        end

        local function vimode_highlight()
            return highlights[_vimode_text[vim.fn.mode()]]
        end

        local function file_name()
            local buftype = vim.bo.buftype
            local max_length = 45
            local name = vim.fn.expand('%')
            local prefix = ''
            local pos = nil

            if buftype == 'nofile' then
                if name == 'gen.nvim' then
                    return ' 󰅏 '
                end
                if name:match('NvimTree') then
                    return ' 󱏒 '
                end
            else
                if buftype ~= '' then
                    return buftype
                end
            end

            if name == '' then
                return ' ⊥ '
            end

            pos = name:find('%?')
            if pos ~= nil then
                name = name:sub(1, name:find('%?') - 1):gsub('/contents', '')
            end

            pos = name:find('/')
            while #name > max_length and pos ~= nil do
                prefix = '../'
                name = name:sub(pos + 1)
                pos = name:find('/')
            end

            return prefix .. name
        end

        local function file_status()
            local bufnr = vim.fn.bufnr()
            if vim.bo.modifiable and vim.bo.modified then
                return '+'
            elseif not require('util.is-editable').is_editable(bufnr) then
                return '🔒'
            else
                return ''
            end
        end

        local function window_status()
            if require('util.toggle-zoom').is_zoomed() then
                return ''
            else
                return ''
            end
        end

        local function diagnostic(prefix, severity)
            return function()
                local count = #vim.diagnostic.get(0, { severity = severity })
                if count == 0 then
                    return ''
                end
                return prefix .. count .. ' '
            end
        end

        local function word_count()
            if vim.bo.filetype == 'markdown' then
                return '󰈭 ' .. vim.fn.wordcount().words
            end
            return ''
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

        local function metals_status()
            if vim.g.metals_status then
                return ' ' .. vim.g.metals_status .. ' '
            else
                return ''
            end
        end

        local function intelligence_status()
            local result = ''
            local ft = vim.bo.filetype

            -- LSP
            local clients = vim.lsp.get_active_clients({ bufnr = 0 })
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

        local function file_type_icon()
            local icon_str, _ = require('nvim-web-devicons').get_icon_color(vim.fn.expand('%:t'), nil, { default = true })
            return icon_str
        end

        local function file_type_icon_hl()
            local _, color = require('nvim-web-devicons').get_icon_color(vim.fn.expand('%:t'), nil, { default = true })
            return { fg = color, bg = colors.white }
        end

        local function file_type()
            local ft = vim.bo.filetype
            if ft == '' then
                return '⊥'
            end
            return ft
        end

        local function file_format()
            local ff = vim.bo.fileformat
            if ff == 'dos' then
                return ''
            elseif ff == 'mac' then
                return ''
            else -- Linux: 
                return ''
            end
        end

        local function file_encoding()
            local fe = vim.bo.fileencoding
            if fe == '' then
                fe = vim.o.encoding
            end
            if fe == '' then
                return 'unknown'
            elseif fe == 'utf-8' then
                return ''
            else
                return fe
            end
        end

        local function position()
            local indicators = { ' ', '▔', '🮂', '🮃', '▀', '🮄', '🮅', '🮆', '█' }
            local line = vim.fn.line('.')
            local col = vim.fn.col('.')
            local total = vim.fn.line('$')
            local progress = ' '
            if total > 1 and line > 1 then
                local idx = math.floor(line / total * (#indicators - 1))
                progress = indicators[idx + 1]
            end
            return line .. ':' .. col .. ' ' .. progress
        end

        local pad = {
            back = {
                provider = ' ',
                hl = highlights.secondary
            },
            vimode = {
                provider = ' ',
                hl = vimode_highlight
            },
            main = {
                provider = ' ',
                hl = highlights.main
            }
        }

        local function compose(fns)
            return function()
                local result = ''
                for i = 1, #fns do
                    local s = fns[i]()
                    if result ~= '' and s ~= '' then
                        result = result .. ' '
                    end
                    if s ~= '' then
                        result = result .. s
                    end
                end
                return result
            end
        end

        local statusline_active = {
            { --left
                pad.back,
                {
                    provider = vimode_text,
                    hl = vimode_highlight,
                    left_sep = left_sep,
                },
                pad.vimode,
                pad.main,
                {
                    provider = compose({ file_name, file_status, window_status }),
                    hl = highlights.main,
                    right_sep = right_sep
                },
                pad.back,
                {
                    provider = autoformat,
                    hl = highlights.secondary
                }
            },
            { -- right
                {
                    provider = compose({ word_count, metals_status }),
                    hl = highlights.secondary
                },
                pad.back,
                {
                    provider = diagnostic(diag.error, vim.diagnostic.severity.ERROR),
                    hl = highlights.error
                },
                {
                    provider = diagnostic(diag.warn, vim.diagnostic.severity.WARN),
                    hl = highlights.warn
                },
                {
                    provider = diagnostic(diag.info, vim.diagnostic.severity.INFO),
                    hl = highlights.info
                },
                {
                    provider = diagnostic(diag.hint, vim.diagnostic.severity.HINT),
                    hl = highlights.hint
                },
                pad.back,
                {
                    provider = compose({ intelligence_status }),
                    hl = highlights.secondary
                },
                pad.back,
                {
                    provider = file_type_icon,
                    hl = file_type_icon_hl,
                    left_sep = left_sep
                },
                pad.main,
                {
                    provider = compose({ file_type, file_format, file_encoding }),
                    hl = highlights.main,
                },
                pad.main,
                pad.vimode,
                {
                    provider = position,
                    hl = vimode_highlight,
                    right_sep = right_sep
                },
                pad.back
            }
        }

        local statusline_inactive = {
            { --left
                pad.back,
                pad.back,
                pad.back,
                pad.back,
                {
                    provider = file_name,
                    hl = highlights.main,
                    left_sep = left_sep,
                    right_sep = right_sep
                }
            },
            { -- right
            }
        }

        require('feline').setup({
            components = {
                active = statusline_active,
                inactive = statusline_inactive
            },
            force_inactive = {
                filetypes = { 'NvimTree', 'qf' },
                buftypes = { 'terminal' }
            },
            theme = {
                bg = colors.background
            }
        })

        -- Fix square in the corner between vertical splits
        vim.api.nvim_set_hl(0, "StatusLineNC", { bg = colors.background })
    end
}
