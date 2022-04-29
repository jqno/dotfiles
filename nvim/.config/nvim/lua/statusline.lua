local This = {}

local fn = vim.fn
local tranquility = require('tranquility').colors()

local function invert_colors()
    local statusline_fg = tranquility.ui.light[1]
    local statusline_bg = tranquility.white.light[1]
    local statuslinenc_fg = tranquility.white.dark[1]
    local statuslinenc_bg = tranquility.black.light[1]
    vim.cmd('highlight StatusLine guifg=' .. statuslinenc_fg .. ' guibg=' .. statuslinenc_bg)
    vim.cmd('highlight StatusLineNC guifg=' .. statusline_fg .. ' guibg=' .. statusline_bg)
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

local function build_statusline()
    require('lualine').setup({
        options = {
            component_separators = '│',
            section_separators = { left = '', right = '' },
            globalstatus = true
        },
        sections = {
            lualine_a = {
                { 'mode',
                    fmt = function(str) return str:sub(1, 1) end,
                    padding = { left = 1, right = 1 },
                    separator = { left = ' ' }
                }
            },
            lualine_b = {
                { 'filename',
                    path = 1,
                    file_status = false,
                    shorting_target = 50,
                    symbols = { unnamed = '⊥' },
                    separator = ''
                },
                filestatus
            },
            lualine_c = {},
            lualine_x = {
                { 'diagnostics',
                    sources = { 'nvim_diagnostic' },
                    sections = { 'error', 'warn', 'hint' },
                    separator = ''
                },
                lsp_status
            },
            lualine_y = {
                { word_count,
                    cond = is_prose
                },
                'filetype',
                { '"⊥"',
                    cond = function() return vim.bo.filetype == '' end
                },
                { 'fileformat',
                    symbols = {
                        unix = '', -- 
                        dos = '',
                        mac = ''
                    }
                },
                file_encoding
            },
            lualine_z = {
                search_result,
                { position,
                    separator = { right = ' ' }
                }
            }
        },
        inactive_sections = {},
        extensions = {
            {
                sections = {
                    lualine_b = {
                        function() return fn.fnamemodify(fn.getcwd(), ':~') end
                    }
                },
                filetypes = { 'NvimTree' }
            },
            {
                sections = {
                    lualine_a = {
                        { qf_label,
                            separator = { left = ' ', right = '' }
                        }
                    },
                    lualine_c = {
                        qf_title
                    },
                    lualine_z = {
                        { position,
                            separator = { left = '', right = ' ' },
                        }
                    }
                },
                filetypes = { 'qf' }
            }
        }
    })
end

function This.setup()
    vim.g.qf_disable_statusline = true
    invert_colors()
    build_statusline()
end

return This
