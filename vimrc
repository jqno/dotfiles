" ***************************************
" ***  Define plugins
" ***************************************

call plug#begin("~/.vim/plugged")

Plug 'fcpg/vim-fahrenheit'
Plug 'tpope/vim-sensible'
Plug 'vimwiki/vimwiki'

call plug#end()



" ***************************************
" ***  Behavior
" ***************************************

" Put swap files and backups in . only as a last resort
set directory-=.
set directory+=.
set backupdir-=.
set backupdir+=.



" ***************************************
" ***  Navigation
" ***************************************

" Pressing up in a long line gets you to the above line 'in the screen',
" but if you precede it with a count, you get the old behavior
" and if the count > 5, we'll also add it to the jump list so we can do C-O and C-I
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'



" ***************************************
" ***  Appearance
" ***************************************

" Make it look purty
colorscheme fahrenheit
set background=dark
" Show line-numbers
set number



" ***************************************
" ***  Plugin configuration
" ***************************************

" VimWiki
nmap <F12> :VimwikiIndex<CR>
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki', 'syntax': 'markdown', 'ext': '.wiki'}]
let g:vimwiki_folding = 'expr'
augroup VimWiki
    autocmd!
    autocmd FileType vimwiki setlocal foldexpr=StackedMarkdownFolds()
augroup END

