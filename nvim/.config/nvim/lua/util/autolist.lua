local This = {}

function This.setup()
    vim.opt_local.formatoptions:append('r')
    vim.opt_local.formatoptions:append('o')
    vim.opt_local.comments =
        'sb:- [x],mb:- [ ],eb:- [ ],' .. -- TODOs starting with '- [x]'
        'sb:* [x],mb:* [ ],eb:* [ ],' .. -- TODOs starting with '* [x]'
        'sb:+ [x],mb:+ [ ],eb:+ [ ],' .. -- TODOs starting with '+ [x]'
        'b:- [ ],b:* [ ],' ..            -- TODOs starting with '- [ ]' or '* [ ]'
        'b:-,b:*,b:+,b:1.,n:>'           -- Lists starting with '-', '*', '+', '1.' or '>'
end

return This
