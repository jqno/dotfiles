vim.filetype.add({
    extension = {
        avsc = 'json',
        conf = 'hocon',
        sbt = 'scala',
    },
    filename = {
        ['pom.xml'] = 'xml.pom'
    },
    pattern = {
        -- Use bash globs; a literal `.` is `%.`
        ['.*/%.github/workflows/.*%.yml'] = 'yaml.github'
    }
})
