return {
    'lewis6991/gitsigns.nvim',
    event = 'UIEnter',

    opts = {
        sign_priority = 2,
        on_attach = function(bufnr)
            local map = vim.keymap.set
            local modes = require('util.modes')

            map(modes.n, ']h', function()
                if vim.wo.diff then return ']c' end
                vim.schedule(require('util.centered').centered(function() require('gitsigns').nav_hunk('next') end))
                return '<Ignore>'
            end, { buffer = bufnr, expr = true, desc = 'go to next git hunk' })

            map(modes.n, '[h', function()
                if vim.wo.diff then return '[c' end
                vim.schedule(require('util.centered').centered(function() require('gitsigns').nav_hunk('prev') end))
                return '<Ignore>'
            end, { buffer = bufnr, expr = true, desc = 'go to previous git hunk' })

            map(modes.n, '<leader>hs', require('gitsigns').stage_hunk, { buffer = bufnr, desc = 'git stage hunk' })
            map(modes.n, '<leader>hS', require('gitsigns').stage_buffer, { buffer = bufnr, desc = 'git stage buffer' })
            map(modes.n, '<leader>hr', require('gitsigns').reset_hunk, { buffer = bufnr, desc = 'git reset hunk' })
            map(modes.n, '<leader>hR', require('gitsigns').reset_buffer, { buffer = bufnr, desc = 'git reset buffer' })
            map(modes.n, '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'git preview hunk' })
            map(modes.n, '<leader>hb', require('gitsigns').blame_line, { buffer = bufnr, desc = 'git blame line' })

            -- Text objects
            map(modes.o, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { buffer = bufnr })
            map(modes.x, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { buffer = bufnr })
        end
    }
}
