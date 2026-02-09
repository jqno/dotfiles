return {
    -- To avoid E828: normally Neovim turns the entire path of a file into a single filename: /home/jqno/foo.bar -> %home%jqno%foo.bar.
    -- Sometimes, that exceeds the maximum file name length, which produces E828 and causes all kinds of issues.
    -- This plugin creates directories in ~/.vim/undodir so filenames can keep their original lengths.
    'pixelastic/vim-undodir-tree',
    event = 'UIEnter'
}
