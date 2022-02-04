local This = {}

local util = require('util')

This.lsp_config = {
    xml = {
        fileAssociations = {
            {
                systemId = 'http://maven.apache.org/xsd/maven-4.0.0.xsd',
                pattern = 'pom.xml'
            }
        }
    }
}

function This.setup()
    util.set_buf_indent(4)
end

return This
