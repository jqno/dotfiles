return {
    'hedyhli/outline.nvim',
    cmd = { 'Outline', 'OutlineOpen', 'OutlineClose' },

    opts = {
        outline_window = { position = 'left' },
        symbol_folding = {
            autofold_depth = false
        },
        symbols = {
            icons = {
                File = { icon = '󰈔', hl = 'Identifier' },
                Module = { icon = '󰆧', hl = 'Include' },
                Namespace = { icon = '󰏗', hl = 'Include' },
                Package = { icon = '󰏗', hl = 'Include' },
                Class = { icon = 'C', hl = 'Type' },
                Method = { icon = 'm', hl = 'Function' },
                Property = { icon = '∴', hl = 'Identifier' },
                Field = { icon = 'f', hl = 'Identifier' },
                Constructor = { icon = '󱐋', hl = 'Special' },
                Enum = { icon = '', hl = 'Type' },
                Interface = { icon = 'I', hl = 'Type' },
                Function = { icon = 'λ', hl = 'Function' },
                Variable = { icon = 'v', hl = 'Constant' },
                Constant = { icon = 'π', hl = 'Constant' },
                String = { icon = '"', hl = 'String' },
                Number = { icon = '#', hl = 'Number' },
                Boolean = { icon = '!', hl = 'Boolean' },
                Array = { icon = '󰅪', hl = 'Constant' },
                Object = { icon = 'O', hl = 'Type' },
                Key = { icon = '󰌆', hl = 'Type' },
                Null = { icon = 'ø', hl = 'Type' },
                EnumMember = { icon = '∴', hl = 'Identifier' },
                Struct = { icon = 'S', hl = 'Structure' },
                Event = { icon = '󱐋', hl = 'Type' },
                Operator = { icon = '+', hl = 'Identifier' },
                TypeParameter = { icon = '𝙏', hl = 'Identifier' },
                Component = { icon = '󰅴', hl = 'Function' },
                Fragment = { icon = '󰅴', hl = 'Constant' },
                TypeAlias = { icon = '𝙏', hl = 'Type' },
                Parameter = { icon = 'p', hl = 'Identifier' },
                StaticMethod = { icon = 'M', hl = 'Function' },
                Macro = { icon = 'X', hl = 'Function' },
            }
        }
    }
}
