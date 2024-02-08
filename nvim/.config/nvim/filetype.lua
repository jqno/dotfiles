local function link(pattern, filetype)
    vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
        pattern = pattern,
        callback = function() vim.opt.filetype = filetype end
    })
end

-- Maven POM
link('pom.xml', 'xml.pom')

-- Scala
link('*.sbt', 'scala')
link('*.worksheet.sc', 'scala')

-- AVRO
link('*.avsc', 'json')

-- HOCON
link('*.conf', 'hocon')
