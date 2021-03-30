local M = {}

function M.setup()
  require'compe'.setup {
    autocomplete = false;

    source = {
      path = true;
      buffer = true;
      tags = true;
      nvim_lsp = true;
      nvim_lua = true;
    }
  }
end

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local function check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

function M.tab_complete()
  if vim.fn.pumvisible() == 1 then
    return t '<C-n>'
  elseif check_back_space() then
    return t '<Tab>'
  else
    return vim.fn['compe#complete']()
  end
end

function M.s_tab_complete()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

return M
