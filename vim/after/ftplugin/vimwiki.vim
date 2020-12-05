autocmd BufEnter *.mkdn setlocal syntax=markdown

inoremap <silent><expr><buffer> <CR> pumvisible() ? tabjqno#accept() : "<C-]><Esc>:VimwikiReturn 1 5<CR>"

