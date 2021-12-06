local This = {}

local fn = vim.fn
local highlight = require('vim-util').highlight
local theme = require('tranquility').colors()

-- HELPERS --
local symbols = {
    open = '',
    close = '',
    splitter = '│',
    bottom = '⊥',
    ok = '✔',
    error = '✗',
    warning = '◆',
    information = 'i',
    hint = 'H'
}

local colors = {
    black = theme.black.light[1],
    green = theme.green.light[1],
    purple = theme.magenta.dark[1],
    red = theme.red.light[1],
    white = theme.white.light[1],
    yellow = theme.yellow.light[1],
    visual = theme.ui.light[1],
    error = theme.error.light[1],
    warning = theme.warning.light[1],
    information = theme.hint.light[1],
    hint = theme.hint.light[1]
}

local schemes = {
    regular = {colors.black, colors.green},
    regular_i = {colors.green, colors.black},
    faded = {colors.black, colors.white},
    faded_i = {colors.white, colors.black},
    diag_ok = {colors.black, colors.green, 'bold'},
    diag_error = {colors.black, colors.error, 'bold'},
    diag_warning = {colors.black, colors.warning, 'bold'},
    diag_information = {colors.black, colors.information},
    diag_hint = {colors.black, colors.hint}
}

local separators = {
    open = function()
        return symbols.open
    end,
    close = function()
        return symbols.close
    end
}

local function space()
    return ' '
end

local function is_prose()
    return vim.bo.filetype == 'markdown'
end

-- VIMODE --
local function vimode_color()
    local mode_colors = {
        N = colors.green,
        I = colors.white,
        V = colors.visual,
        [''] = colors.visual,
        T = colors.yellow,
        C = colors.purple
    }
    local c = mode_colors[fn.mode():upper():sub(1, 1)]
    if c then
        return c
    end
    return colors.red
end

local function vimode()
    local c = vimode_color()
    highlight('GalaxyViMode', schemes.regular[1], c)
    highlight('GalaxyViModeOpen', c, schemes.regular_i[2])
    highlight('GalaxyViModeClose', c, schemes.regular_i[2])

    local mode = fn.mode():upper()
    if mode == '' then
        return 'V'
    elseif mode == '' then
        return '^S'
    elseif mode == 'no' then
        return 'no^V'
    else
        return mode
    end
end

-- FILENAME --
local function filename_modification_raw()
    local status = ''
    if vim.bo.modifiable and vim.bo.modified then
        status = status .. '+'
    end
    if not vim.bo.modifiable or vim.bo.readonly then
        status = status .. '-'
    end
    return status
end

local function filename_modification()
    local status = filename_modification_raw()

    if status == '' then
        highlight('GalaxyFileNameClose', schemes.regular_i[1],
                  schemes.regular_i[2])
    else
        highlight('GalaxyFileNameClose', schemes.faded_i[1], schemes.faded_i[2])
    end

    if status == '' then
        return ''
    end
    return '  ' .. status
end

local function filename()
    local name = fn.expand('%:t')
    if name == '' then
        name = symbols.bottom
    end
    if filename_modification_raw() == '' then
        return name
    end
    return name .. ' '
end

-- LSP --
local function lsp_metals_status()
    local status = vim.g.metals_status
    if vim.bo.filetype == 'scala' and status and status ~= '' then
        return ' - ' .. status
    end
    return ''
end

local function lsp_status()
    local clients = vim.lsp.buf_get_clients(0)
    local connected = not vim.tbl_isempty(clients)
    if connected then
        local status = ''
        for _, client in ipairs(clients) do
            status = status .. ' ' .. client.name
        end
        status = status .. lsp_metals_status()
        return status
    else
        return ''
    end
end

local function lsp_separator(sep)
    if lsp_status() == '' then
        return ''
    end
    return sep
end

-- DIAGNOSTICS --
local function diags()
    return {
        error = vim.tbl_count(vim.diagnostic.get(0, {
            severity = vim.diagnostic.severity.ERROR
        })),
        warning = vim.tbl_count(vim.diagnostic.get(0, {
            severity = vim.diagnostic.severity.WARN
        })),
        information = vim.tbl_count(vim.diagnostic.get(0, {
            severity = vim.diagnostic.severity.INFO
        })),
        hint = vim.tbl_count(vim.diagnostic.get(0, {
            severity = vim.diagnostic.severity.HINT
        }))
    }
end

local function diag_print_open()
    local d = diags()
    local scheme = schemes.diag_ok
    if d.error > 0 then
        scheme = schemes.diag_error
    elseif d.warning > 0 then
        scheme = schemes.diag_warning
    elseif d.information > 0 then
        scheme = schemes.diag_information
    elseif d.hint > 0 then
        scheme = schemes.diag_hint
    end
    highlight('GalaxyDiagnosticOpen', scheme[2], scheme[1])
    return symbols.open
end

local function diag_print_close()
    local d = diags()
    local scheme = schemes.diag_ok
    if d.hint > 0 then
        scheme = schemes.diag_hint
    elseif d.information > 0 then
        scheme = schemes.diag_information
    elseif d.warning > 0 then
        scheme = schemes.diag_warning
    elseif d.error > 0 then
        scheme = schemes.diag_error
    end
    highlight('GalaxyDiagnosticClose', scheme[2], scheme[1])
    return symbols.close
end

local function diag_print_ok()
    local d = diags()
    if d.error == 0 and d.warning == 0 and d.information == 0 and d.hint == 0 then
        return symbols.ok
    end
    return ''
end

local function diag_print_error()
    local d = diags()
    if d.error == 0 then
        return ''
    end
    local suffix = ''
    if d.warning > 0 or d.information > 0 or d.hint > 0 then
        suffix = ' '
    end
    return symbols.error .. d.error .. suffix
end

local function diag_print_warning()
    local d = diags()
    if d.warning == 0 then
        return ''
    end
    local prefix = ''
    if d.error > 0 then
        prefix = '  '
    end
    local suffix = ''
    if d.information > 0 or d.hint > 0 then
        suffix = ' '
    end
    return prefix .. symbols.warning .. d.warning .. suffix
end

local function diag_print_information()
    local d = diags()
    if d.information == 0 then
        return ''
    end
    local prefix = ''
    if d.error > 0 or d.warning > 0 or d.hint > 0 then
        prefix = '  '
    end
    return prefix .. symbols.information .. d.information
end

local function diag_print_hint()
    local d = diags()
    if d.hint == 0 then
        return ''
    end
    local prefix = ''
    if d.error > 0 or d.warning > 0 then
        prefix = '  '
    end
    local suffix = ''
    if d.information > 0 then
        suffix = ' '
    end
    return prefix .. symbols.hint .. d.hint .. suffix
end

-- FILE INFO --
local function fileinfo_extra()
    local ff = vim.bo.fileformat
    if ff == '' then
        ff = 'unknown'
    elseif ff == 'unix' then
        ff = ''
    end

    local fe = vim.bo.fileencoding
    if fe == '' then
        fe = vim.o.encoding
    end
    if fe == '' then
        fe = 'unknown'
    elseif fe == 'utf-8' then
        fe = ''
    end

    if ff == '' and fe == '' then
        highlight('GalaxyFileInfoClose', schemes.regular_i[1],
                  schemes.regular_i[2])
        return ''
    elseif ff ~= '' and fe ~= '' then
        highlight('GalaxyFileInfoClose', schemes.faded_i[1], schemes.faded_i[2])
        return '  ' .. ff .. ' ' .. symbols.splitter .. ' ' .. fe
    else
        highlight('GalaxyFileInfoClose', schemes.faded_i[1], schemes.faded_i[2])
        return '  ' .. ff .. fe
    end
end

local function fileinfo_type()
    local ft = vim.bo.filetype
    if ft == '' then
        ft = symbols.bottom
    end
    if fileinfo_extra() ~= '' then
        return ft .. ' '
    end
    return ft
end

-- POSITION --
local function position_current()
    return fn.line('.') .. ':' .. (fn.col('.')) .. ' '
end

local function position_max()
    return fn.line('$') .. ':' .. (fn.col('$') - 1)
end

-- STATUSLINE --
local function configure_highlights()
    highlight('StatusLine', schemes.faded_i[1], schemes.faded_i[2])
    highlight('StatusLineNC', schemes.faded_i[1], schemes.faded_i[2])
end

local function setup_statusline()
    local gl = require('galaxyline')
    local gls = gl.section

    gl.short_line_list = {'NvimTree', 'dap-repl'}

    --- LEFT ---
    gls.left = {
        --- START ---
        {StartSpace = {provider = space, highlight = schemes.regular_i}},

        --- MODE ---
        {ViModeOpen = {provider = separators.open}},
        {ViMode = {provider = vimode}}, {
            ViModeClose = {
                provider = separators.close,
                separator = ' ',
                separator_highlight = schemes.faded_i
            }
        }, --- FILENAME ---
        {
            FileNameOpen = {
                provider = separators.open,
                highlight = schemes.regular_i
            }
        }, {FileName = {provider = filename, highlight = schemes.regular}}, {
            FileNameModification = {
                provider = filename_modification,
                highlight = schemes.faded
            }
        }, {FileNameClose = {provider = separators.close}}
    }

    --- RIGHT ---
    gls.right = {
        --- LSP ---
        {
            LspOpen = {
                provider = function()
                    return lsp_separator(symbols.open)
                end,
                highlight = schemes.faded_i,
                separator = '%<'
            }
        }, {LspShowClient = {provider = lsp_status, highlight = schemes.faded}},
        {
            LspClose = {
                provider = function()
                    return lsp_separator(symbols.close .. ' ')
                end,
                highlight = schemes.faded_i
            }
        }, --- DIAGNOSTICS ---
        {DiagnosticOpen = {provider = diag_print_open}},
        {DiagnosticOk = {provider = diag_print_ok, highlight = schemes.diag_ok}},
        {
            DiagnosticError = {
                provider = diag_print_error,
                highlight = schemes.diag_error
            }
        }, {
            DiagnosticWarning = {
                provider = diag_print_warning,
                highlight = schemes.diag_warning
            }
        }, {
            DiagnosticInformation = {
                provider = diag_print_information,
                highlight = schemes.diag_information
            }
        },
        {
            DiagnosticHint = {
                provider = diag_print_hint,
                highlight = schemes.diag_hint
            }
        }, {DiagnosticClose = {provider = diag_print_close}},
        {DiagnosticSpace = {provider = space, highlight = schemes.faded_i}},

        --- WORD COUNT ---
        {
            WordCountOpen = {
                provider = separators.open,
                condition = is_prose,
                highlight = schemes.faded_i
            }
        }, {
            WordCount = {
                provider = function()
                    return fn.wordcount().words .. ' words'
                end,
                condition = is_prose,
                highlight = schemes.faded
            }
        }, {
            WordCountClose = {
                provider = {separators.close, space},
                condition = is_prose,
                highlight = schemes.faded_i
            }
        }, --- FILE INFO ---
        {
            FileInfoOpen = {
                provider = separators.open,
                highlight = schemes.regular_i
            }
        },
        {FileInfoType = {provider = fileinfo_type, highlight = schemes.regular}},
        {FileInfoExtra = {provider = fileinfo_extra, highlight = schemes.faded}},
        {
            FileInfoClose = {
                provider = {separators.close, space},
                highlight = schemes.regular_i
            }
        }, --- POSITION ---
        {
            PositionOpen = {
                provider = separators.open,
                highlight = schemes.regular_i
            }
        },
        {
            PositionCurrent = {
                provider = position_current,
                highlight = schemes.regular
            }
        }, {
            PositionMax = {
                provider = position_max,
                highlight = schemes.faded,
                separator = ' ',
                separator_highlight = schemes.faded
            }
        },
        {
            PositionClose = {
                provider = separators.close,
                highlight = schemes.faded_i
            }
        }, --- END ---
        {EndSpace = {provider = space, highlight = schemes.regular_i}}
    }

    --- INACTIVE --
    gls.short_line_left = {
        {
            InactiveSpaces = {
                provider = function()
                    return '       '
                end,
                highlight = schemes.faded_i
            }
        },
        {InactiveFileName = {provider = filename, highlight = schemes.faded_i}}
    }
end

function This.setup()
    configure_highlights()
    setup_statusline()
end

return This
