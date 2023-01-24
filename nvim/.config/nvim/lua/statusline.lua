local This = {}

local diag = require('util').diag_strings

local left_sep = ''
local right_sep = ''

local _vimode_text = {
    n = 'N',
    no = 'N',
    i = 'I',
    v = 'V',
    V = 'V',
    [''] = 'V',
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
    black = '#252525',
    green = '#70b433',
    white = '#dedede',
}

local highlights = {
    main = {
        bg = colors.white,
        fg = colors.black
    },
    secondary = 'StatusLineNC'
}

local vimode_highlights = {
    N = 'DiffAdd',
    I = 'DiffChange',
    V = 'Visual',
    C = 'TermCursor',
    R = 'DiffChange',
    S = 'DiffChange',
    T = 'IncSearch'
}

local function vimode_text()
    return _vimode_text[vim.fn.mode()]
end

local function vimode_highlight()
    return vimode_highlights[_vimode_text[vim.fn.mode()]]
end

local function file_name()
    local max_length = 45
    local name = vim.fn.expand('%')
    local prefix = ''
    local pos = nil

    if name == '' then
        return '⊥'
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

local function word_count()
    if vim.bo.filetype == 'markdown' then
        return vim.fn.wordcount().words .. ' words'
    end
    return ''
end

local function file_status()
    if vim.bo.modifiable and vim.bo.modified then
        return '+'
    elseif not vim.bo.modifiable or vim.bo.readonly then
        return '🔒'
    else
        return ''
    end
end

local function get_diag(prefix, severity)
    local count = #vim.diagnostic.get(0, { severity = severity })
    if count == 0 then
        return ''
    end
    return prefix .. count
end

local function diagnostics()
    return get_diag(diag.error, vim.diagnostic.severity.ERROR) ..
        get_diag(diag.warn, vim.diagnostic.severity.WARN) ..
        get_diag(diag.hint, vim.diagnostic.severity.HINT)
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

        return status
    else
        return ''
    end
end

local function file_type()
    local ft = vim.bo.filetype
    if ft == '' then
        return '⊥'
    end
    local icon_str, _ = require('nvim-web-devicons').get_icon_color(vim.fn.expand('%:t'), nil, { default = true })
    return icon_str .. ' ' .. ft
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
        hl = 'StatusLineNC'
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
            provider = compose({ file_name, file_status }),
            hl = highlights.main,
            right_sep = right_sep
        }
    },
    { -- right
        {
            provider = compose({ word_count, diagnostics, lsp_status }),
            hl = highlights.secondary
        },
        pad.back,
        {
            provider = compose({ file_type, file_format, file_encoding }),
            hl = highlights.main,
            left_sep = left_sep
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

local function build_statusline()
    require('feline').setup({
        components = {
            active = statusline_active,
            inactive = statusline_inactive
        },
        force_inactive = {
            filetypes = { 'NvimTree', 'qf' },
            buftypes = { 'terminal' }
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
