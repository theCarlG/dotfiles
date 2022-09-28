local keymap = require("CarlG.utils.keymap")
local map = keymap.map
local nmap = keymap.nmap
local noremap = keymap.noremap
local inoremap = keymap.inoremap
local nnoremap = keymap.nnoremap
local vnoremap = keymap.vnoremap
local xnoremap = keymap.xnoremap

--- Visual shifting (does not exit Visual mode)
vnoremap('<', '<gv')
vnoremap('>', '>gv')

xnoremap('<leader>p', '"_dP')

-- If I need help, I'll ask for it.
inoremap('<F1>', '<ESC>')
nnoremap('<F1>', '<ESC>')
vnoremap('<F1>', '<ESC>')

-- Use tab to jump between bracets instead of %
nnoremap('<tab>', '%')
vnoremap('<tab>', '%')

-- Make regex search work more like it -SHOULD-
nnoremap('/', '/\\v')
vnoremap('/', '/\\v')

-- Disable arrow keys
nnoremap('<up>', '<nop>')
nnoremap('<down>', '<nop>')
nnoremap('<left>', '<nop>')
nnoremap('<right>', '<nop>')
inoremap('<up>', '<nop>')
inoremap('<down>', '<nop>')
inoremap('<left>', '<nop>')
inoremap('<right>', '<nop>')

-- Wrapped lines goes down/up to next row, rather than next line in file.
noremap('j', 'gj')
noremap('k', 'gk')

-- Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap('Y', 'y$')

nnoremap('<C-t>', "<cmd>:e #<CR>")
nnoremap('-', "'")
--noremap('.', '<cmd>:normal .<CR>')

-- Easier moving in tabs and windows
map('<C-J>', '<C-W>j<C-W>_')
map('<C-K>', '<C-W>k<C-W>_')
map('<C-L>', '<C-W>l<C-W>_')
map('<C-H>', '<C-W>h<C-W>_')

-- Disable number inc/dec binds
--nmap('<C-a>', '<Nop>')
--nmap('<C-x>', '<Nop>')

-- Fast tabs
map('<S-H>', 'gT')
map('<S-L>', 'gt')

