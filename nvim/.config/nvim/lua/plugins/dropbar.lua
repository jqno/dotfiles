return {
    'Bekaboo/dropbar.nvim',
    event = 'UIEnter',

    config = function()
        vim.opt.mousemoveevent = true
        vim.api.nvim_set_hl(0, 'WinBar', { link = 'Normal' })
        vim.api.nvim_set_hl(0, 'WinBarNC', { link = 'Normal' })

        require('dropbar').setup({
            bar = {
                sources = function(buf, _)
                    local sources = require('dropbar.sources')
                    local utils = require("dropbar.utils")
                    local filename = {
                        get_symbols = function(buff, win, cursor)
                            local paths = sources.path.get_symbols(buff, win, cursor)
                            return { paths[#paths] }
                        end,
                    }
                    if vim.bo[buf].ft == 'scala' then
                        return {
                            filename,
                            utils.source.fallback({
                                sources.lsp,
                                sources.treesitter
                            })
                        }
                    end
                    if vim.bo[buf].ft == 'markdown' then
                        return {
                            sources.path,
                            sources.markdown,
                        }
                    end
                    if vim.bo[buf].buftype == 'terminal' then
                        return {
                            sources.terminal
                        }
                    end
                    return {
                        sources.path,
                        utils.source.fallback({
                            sources.lsp,
                            sources.treesitter
                        })
                    }
                end
            }
        })
    end,
}
