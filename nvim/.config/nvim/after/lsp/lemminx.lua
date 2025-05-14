return {
    filetypes = { 'xml', 'xsd', 'xsl', 'xslt', 'svg', 'xml.pom' },
    settings = {
        xml = {
            fileAssociations = {
                {
                    systemId = 'http://maven.apache.org/xsd/maven-4.0.0.xsd',
                    pattern = 'pom.xml'
                }
            }
        }
    }
}
