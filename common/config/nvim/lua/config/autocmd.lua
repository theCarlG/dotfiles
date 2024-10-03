local au = require('utils.au')

au.group('TermGroup', {
    { "TermOpen", "*", "tnoremap <buffer> <Esc> <c-\\><c-n>" },
    { "TermOpen", "*", "startinsert" },
    { "TermOpen", "*", "setlocal listchars= nonumber norelativenumber" },
})
au("InsertEnter", "setlocal nohlsearch")
au("TextYankPost", 'silent! lua vim.highlight.on_yank() {higroup="IncSearch", timeout=400}');

-- Restore cursor
au("BufRead", 'call setpos(".", getpos("\'\\""))')

au({ 'BufNewFile', 'BufRead' }, {
    '*.proto',
    function()
        vim.opt.tabstop = 2
        vim.opt.softtabstop = 2
        vim.opt.shiftwidth = 2
        vim.bo.filetype = 'proto'
    end,
})

au({ 'BufNewFile', 'BufRead' }, {
    'BUILD.plz',
    function()
        vim.bo.filetype = 'bzl'
    end,
})
au({ 'BufNewFile', 'BufRead' }, {
    '*.build_defs',
    function()
        vim.bo.filetype = 'python'
    end,
})
au({ 'BufNewFile', 'BufRead' }, {
    '.plzconfig',
    function()
        vim.bo.filetype = 'gitconfig'
    end,
})
au({ 'BufNewFile', 'BufRead' }, {
    '.eslintrc,.prettierrc,*.json*',
    function()
        vim.bo.filetype = 'json'
    end,
})

au({ 'BufNewFile', 'BufRead' }, {
    '*.jsonnet',
    function()
        vim.bo.filetype = 'jsonnet'
    end,
})


-- GLSL
au({ 'BufNewFile', 'BufRead' }, {
    '*.vert,*.tesc,*.tese,*.geom,*.frag,*.comp',
    function()
        vim.bo.filetype = 'glsl'
    end,
})

-- GLSL
au({ 'BufNewFile', 'BufRead' }, {
    '*.wgsl',
    function()
        vim.bo.filetype = 'wgsl'
    end,
})
