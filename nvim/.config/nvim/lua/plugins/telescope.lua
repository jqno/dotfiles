return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'kyazdani42/nvim-web-devicons'
    },
    cmd = 'Telescope',
    config = function()
        local telescope = require('telescope')
        local actions = require('telescope.actions')
        local letters = { a = '🇦', b = '🇧', c = '🇨', d = '🇩', e = '🇪', f = '🇫', g = '🇬', h = '🇭', i = '🇮', j = '🇯', k = '🇰', l = '🇱', m = '🇲', n = '🇳', o = '🇴', p = '🇵', q = '🇶', r = '🇷', s = '🇸', t = '🇹', u = '🇺', v = '🇻', w = '🇼', x = '🇽', y = '🇾', z = '🇿' }
        local space = '/'

        telescope.setup({
            defaults = {
                vimgrep_arguments = {
                    'rg', '--color=never', '--no-heading', '--with-filename',
                    '--line-number', '--column', '--smart-case', '--hidden'
                },
                mappings = {
                    i = {
                        ['<Space>'] = actions.select_horizontal,
                        ['<C-L>'] = actions.select_vertical,
                        ['<Esc>'] = actions.close
                    }
                },
                layout_strategy = 'vertical',
                prompt_prefix = '❯ ',
                selection_caret = '❯ ',
                path_display = function(_, path)
                    local replacement = ''
                    local lang = path:match('src/main/(%a)%a*/')
                    if lang ~= nil then
                        replacement = letters.s .. space .. letters.m .. space .. letters[lang]
                    else
                        lang = path:match('src/test/(%a)%a*/')
                        if lang ~= nil then
                            replacement = letters.s .. space .. letters.t .. space .. letters[lang]
                        end
                    end
                    return path:gsub('src/(%a*)/(%a*)', replacement)
                end
            },
            extensions = {
                ['ui-select'] = { require('telescope.themes').get_dropdown() }
            }
        })
    end
}
