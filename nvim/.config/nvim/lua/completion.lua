local This = {}

function This.setup()
  require'compe'.setup {
    autocomplete = false;
    preselect = 'always';

    source = {
      path = { priority = 100 };
      buffer = { priority = 50 };
      tags = { priority = 60 };
      nvim_lsp = { priority = 70 };
      nvim_lua = { priority = 80 };
      ultisnips = { priority = 90 };
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

function This.tab_complete()
  if vim.fn.pumvisible() == 1 then
    return t '<C-n>'
  elseif check_back_space() then
    return t '<Tab>'
  else
    return vim.fn['compe#complete']()
  end
end

function This.s_tab_complete()
  if vim.fn.pumvisible() == 1 then
    return t '<C-p>'
  else
    return t '<S-Tab>'
  end
end

function This.cr_complete()
  if vim.fn.pumvisible() == 1 then
    return vim.fn['compe#confirm']('<CR>')
  else
    return vim.fn['JqnoAutocloseSmartReturn']()
  end
end

return This
