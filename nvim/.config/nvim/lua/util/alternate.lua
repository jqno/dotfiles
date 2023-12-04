local This = {}

local split_direction = {
    left  = { 'wincmd h', 'vsplit | wincmd h' },
    down  = { 'wincmd j', 'split' },
    up    = { 'wincmd k', 'split | wincmd k' },
    right = { 'wincmd l', 'vsplit' }
}

function This.open_split(direction)
    if direction ~= nil then
        local win_before = vim.api.nvim_get_current_win()
        vim.cmd(split_direction[direction][1])
        local win_after = vim.api.nvim_get_current_win()
        if win_before == win_after then
            vim.cmd(split_direction[direction][2])
        end
    end
end

local function find_alternate()
    local curr = vim.fn.expand('%')
    if vim.bo.filetype == 'java' then
        if curr:find('src/main/java') then
            local prefixed = curr:gsub('src/main/java', 'src/test/java')
            local it = prefixed:gsub('%.java', 'IT.java')
            if vim.fn.filereadable(it) == 1 then
                return it
            end
            return prefixed:gsub('%.java', 'Test.java')
        elseif curr:find('src/test/java') then
            return curr:gsub('src/test/java', 'src/main/java'):gsub('Test%.java', '.java'):gsub('IT%.java', '.java')
        end
    elseif vim.bo.filetype == 'scala' then
        if curr:find('src/main/scala') then
            local prefixed = curr:gsub('src/main/scala', 'src/test/scala')
            local it = prefixed:gsub('%.scala', 'Test.scala')
            if vim.fn.filereadable(it) == 1 then
                return it
            end
            return prefixed:gsub('%.scala', 'Spec.scala')
        elseif curr:find('src/test/scala') then
            return curr:gsub('src/test/scala', 'src/main/scala'):gsub('Spec%.scala', '.scala'):gsub('Test%.scala',
                '.scala')
        end
    elseif vim.bo.filetype == 'go' then
        if curr:find('_test.go') then
            return curr:gsub('_test.go$', '.go')
        else
            return curr:gsub('.go$', '_test.go')
        end
    end
    return nil
end

function This.open_definition(direction)
    local current = vim.fn.expand('%')
    local current_line = vim.fn.line('.')
    local current_col = vim.fn.col('.')

    -- open same file in desired split
    This.open_split(direction)
    vim.cmd.e(current)

    -- make sure we're on the same cursor position
    vim.cmd.norm(current_line .. 'G')
    vim.cmd.norm('|' .. current_col .. 'lh')

    -- go to definition
    vim.lsp.buf.definition({ reuse_win = true })
end

function This.open_alternate(direction)
    local alternate = find_alternate()
    This.open_split(direction)
    if alternate ~= nil then
        vim.cmd.e(alternate)
    end
end

return This
