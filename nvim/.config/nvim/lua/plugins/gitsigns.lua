return {
    'lewis6991/gitsigns.nvim',

    opts = {
        preview_config = {
            border = 'rounded'
        },
        keymaps = {
            noremap = true,
            buffer = true,

            ['n ]g'] = {
                expr = true,
                [[&diff ? ']c' : '<cmd>lua require("gitsigns").next_hunk()<CR>']]
            },
            ['n [g'] = {
                expr = true,
                [[&diff ? '[c' : '<cmd>lua require("gitsigns").prev_hunk()<CR>']]
            },

            ['n <leader>Gs'] = '<cmd>lua require("gitsigns").stage_hunk()<CR>',
            ['n <leader>Gu'] = '<cmd>lua require("gitsigns").undo_stage_hunk()<CR>',
            ['n <leader>Gr'] = '<cmd>lua require("gitsigns").reset_hunk()<CR>',
            ['n <leader>GR'] = '<cmd>lua require("gitsigns").reset_buffer()<CR>',
            ['n <leader>Gp'] = '<cmd>lua require("gitsigns").preview_hunk()<CR>',
            ['n <leader>Gb'] = '<cmd>lua require("gitsigns").blame_line()<CR>',

            -- Text objects
            ['o ig'] = ':<C-U>lua require("gitsigns").select_hunk()<CR>',
            ['x ig'] = ':<C-U>lua require("gitsigns").select_hunk()<CR>'
        }
    }
}
