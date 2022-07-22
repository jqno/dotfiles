local This = {}

local fn = vim.fn

local function custom_theme()
    local theme = require('lualine.themes.auto')
    local black = '#252525'
    theme.normal.a.fg = black
    theme.normal.a.gui = nil
    theme.normal.b.fg = black
    theme.insert.b.fg = black
    theme.replace.b.fg = black
    theme.command.b.fg = black
    theme.visual.b.fg = black
    theme.inactive = { b = { bg = '#777777' } }
    return theme
end

local function filestatus()
    if vim.bo.modifiable and vim.bo.modified then
        return '+'
    elseif not vim.bo.modifiable or vim.bo.readonly then
        return '-'
    else
        return ''
    end
end

local function lsp_status()
    local clients = vim.lsp.buf_get_clients(0)
    local connected = not vim.tbl_isempty(clients)
    if connected then
        local status = ''
        for _, client in pairs(clients) do
            if status == '' then
                status = status .. client.name
            else
                status = status .. ' ' .. client.name
            end
        end

        local metals_status = vim.g.metals_status
        if vim.bo.filetype == 'scala' and status and status ~= '' then
            status = status .. ' - ' .. metals_status
        end

        return status
    else
        return ''
    end
end

local function word_count()
    return fn.wordcount().words .. ' words'
end

local function is_prose()
    return vim.bo.filetype == 'markdown'
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

local function search_result()
    if vim.v.hlsearch == 0 then
        return ''
    end
    local last_search = vim.fn.getreg('/')
    if not last_search or last_search == '' then
        return ''
    end
    local searchcount = vim.fn.searchcount { maxcount = 9999 }
    return last_search .. '(' .. searchcount.current .. '/' .. searchcount.total .. ')'
end

local function position()
    return fn.line('.') .. ':' .. fn.col('.')
end

local function qf_is_loclist()
    return fn.getloclist(0, { filewinid = 1 }).filewinid ~= 0
end

local function qf_label()
    if qf_is_loclist() then
        return 'Location List'
    else
        return 'Quickfix List'
    end
end

local function qf_title()
    if qf_is_loclist then
        return vim.fn.getloclist(0, { title = 0 }).title
    else
        return vim.fn.getqflist({ title = 0 }).title
    end
end

local leftpad = { left = 1, right = 0 }
local rightpad = { left = 0, right = 1 }
local nopad = { left = 0, right = 0 }

local sections = {
    mode = { 'mode',
        fmt = function(str) return str:sub(1, 1) end,
        padding = rightpad,
        separator = { left = ' ' }
    },
    filename = { 'filename',
        path = 1,
        file_status = false,
        shorting_target = 50,
        symbols = { unnamed = '⊥' },
        padding = leftpad,
        separator = ''
    },
    filestatus = { filestatus,
        padding = leftpad,
    },
    diagnostics = { 'diagnostics',
        sources = { 'nvim_diagnostic' },
        sections = { 'error', 'warn', 'hint' },
        separator = ''
    },
    lsp_status = lsp_status,
    word_count = { word_count,
        cond = is_prose
    },
    filetype = { 'filetype',
        padding = rightpad
    },
    no_filetype = { '"⊥"',
        cond = function() return vim.bo.filetype == '' end,
        padding = rightpad
    },
    fileformat = { 'fileformat',
        symbols = {
            unix = '', -- 
            dos = '',
            mac = ''
        }
    },
    file_encoding = { file_encoding },
    search_result = { search_result },
    position = { position,
        padding = leftpad,
        separator = { right = ' ' }
    }
}

local function build_statusline()
    require('lualine').setup({
        options = {
            theme = custom_theme(),
            component_separators = '│',
            section_separators = { left = '', right = '' },
            globalstatus = false
        },
        sections = {
            lualine_a = { sections.mode },
            lualine_b = { sections.filename, sections.filestatus },
            lualine_c = {},
            lualine_x = { sections.diagnostics, sections.lsp_status, sections.word_count },
            lualine_y = { sections.filetype, sections.no_filetype, sections.fileformat, sections.file_encoding },
            lualine_z = { sections.search_result, sections.position }
        },
        inactive_sections = {
            lualine_a = { sections.mode },
            lualine_b = { sections.filename, sections.filestatus },
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {}
        },
        extensions = {
            {
                sections = {
                    lualine_b = {
                        { '"files"',
                            padding = nopad,
                            separator = { left = ' ', right = '' }
                        }
                    }
                },
                filetypes = { 'NvimTree' }
            },
            {
                sections = {
                    lualine_b = {
                        { qf_label,
                            padding = nopad,
                            separator = { left = ' ', right = '' }
                        }
                    },
                    lualine_c = {
                        qf_title
                    },
                    lualine_z = {
                        { position,
                            padding = nopad,
                            separator = { left = '', right = ' ' },
                        }
                    }
                },
                filetypes = { 'qf' }
            }
        }
    })
end

local function tweak_highlights()
    local hl_statusline = vim.api.nvim_get_hl_by_name("StatusLine", true)
    vim.api.nvim_set_hl(0, "StatusLineNC", { bg = hl_statusline.background })
end

function This.setup()
    vim.g.qf_disable_statusline = true
    build_statusline()
    tweak_highlights()
end

return This
