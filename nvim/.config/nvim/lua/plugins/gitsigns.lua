return {
    'lewis6991/gitsigns.nvim',

    opts = {
        preview_config = {
            border = 'rounded'
        },
        on_attach = function(bufnr)
            local map = vim.keymap.set
            local modes = require('util.modes')

            map(modes.n, ']g', function()
                if vim.wo.diff then return ']c' end
                vim.schedule(require('gitsigns').next_hunk)
                return '<Ignore>'
            end, { buffer = bufnr, expr = true, desc = 'go to next git hunk' })

            map(modes.n, '[g', function()
                if vim.wo.diff then return '[c' end
                vim.schedule(require('gitsigns').prev_hunk)
                return '<Ignore>'
            end, { buffer = bufnr, expr = true, desc = 'go to previous git hunk' })

            map(modes.n, '<leader>Gs', require('gitsigns').stage_hunk, { buffer = bufnr, desc = 'git stage hunk' })
            map(modes.n, '<leader>Gu', require('gitsigns').undo_stage_hunk,
                { buffer = bufnr, desc = 'git undo stage hunk' })
            map(modes.n, '<leader>Gr', require('gitsigns').reset_hunk, { buffer = bufnr, desc = 'git reset hunk' })
            map(modes.n, '<leader>GR', require('gitsigns').reset_buffer, { buffer = bufnr, desc = 'git reset buffer' })
            map(modes.n, '<leader>Gp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'git preview hunk' })
            map(modes.n, '<leader>Gb', require('gitsigns').blame_line, { buffer = bufnr, desc = 'git blame line' })

            -- Text objects
            map(modes.o, 'ig', ':<C-U>Gitsigns select_hunk<CR>', { buffer = bufnr })
            map(modes.x, 'ig', ':<C-U>Gitsigns select_hunk<CR>', { buffer = bufnr })
        end
    }
}
