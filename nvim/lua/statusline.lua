local gl = require('galaxyline')
local condition = require('galaxyline.condition')
local gls = gl.section

local function lsp_status()
  local clients = vim.lsp.buf_get_clients(0)
  local connected = not vim.tbl_isempty(clients)
  if connected then
    local status = ''
    for _, client in ipairs(clients) do
      status = status .. ' ' .. client.name
    end
    return status
  else
    return ' '
  end
end

gls.left = {
  {
    ViMode = {
      provider = function() return vim.fn.mode():upper() end,
      separator = ' '
    }
  },
  {
    FileName = {
      provider = 'FileName',
      condition = condition.buffer_not_empty,
    }
  }
}

gls.right = {
  {
    MetalsStatus = {
      provider = function()
        local status = vim.g.metals_status
        if status then
          return status .. ' '
        end
        return ''
      end,
      condition = function() return vim.bo.filetype == 'scala' end,
    }
  },
  {
    ShowLspClient = {
      provider = lsp_status,
    }
  },
  {
    WordCount = {
      provider = function() return vim.fn.wordcount().words .. ' words' end,
      condition = function() return vim.bo.filetype == 'markdown' end
    }
  },
  {
    BufferType = {
      provider = function()
        return vim.bo.filetype .. ' '
      end,
      separator = ' '
    }
  },
  {
    LineInfo = {
      provider = 'LineColumn',
    }
  },
  {
    Space = {
      provider = function() return ' ' end
    }
  },
  {
    DiagnosticError = {
      provider = 'DiagnosticError',
      icon = '✗',
    }
  },
  {
    DiagnosticWarn = {
      provider = 'DiagnosticWarn',
      icon = '◆',
    }
  },
  {
    DiagnosticHint = {
      provider = 'DiagnosticHint',
      icon = 'H',
    }
  },
  {
    DiagnosticInfo = {
      provider = 'DiagnosticInfo',
      icon = 'i',
    }
  }
}
