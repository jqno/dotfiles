local format = [[\nOutput the result in the format ```$filetype\n...\n```.]]
local code = [[\nIf I didn't provide code, say so briefly and don't give additional advice.\n```$filetype\n$text\n```]]

return {
    'David-Kunz/gen.nvim',
    cmd = 'Gen',

    opts = {
        model = 'codellama:7b',
        display_mode = 'split',
        show_prompt = true,
        prompts = {
            -- Interactive
            Chat = { prompt = '$input' },
            Ask = { prompt = '$input\n$text' },

            -- Generate code
            ['Optimize code'] = { prompt = 'Optimize and simplify the following code.' .. format .. code },
            ['Generate doc comment'] = { prompt = 'Generate a doc comment for the following code and stop once the comment is complete.' .. format .. code },
            ['Generate tests'] = { prompt = 'Generate unit tests for the following code. Write short to-the-point test methods with only one or two asserts each.' .. format .. code },

            -- Talk about code
            ['Review code'] = { prompt = 'Review the following code and make concise suggestions. Give extra weight to bugs.' .. code },
            ['Explain code'] = { prompt = 'Explain the following code.' .. code },
            ['Analyse code readability'] = { prompt = 'Analyse the readability of the following code.' .. code }
        }
    }
}
