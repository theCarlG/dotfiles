vim.g.vim_markdown_conceal = 2
vim.g.tex_conceal = ""
vim.g.vim_markdown_math = 1
vim.g.vim_markdown_json_frontmatter = 1
vim.g.vim_markdown_frontmatter = 1
vim.g.vim_markdown_toml_frontmatter = 1

require("CarlG.keymap")
require("CarlG.plugins")
require("CarlG.lsp")
require("CarlG.dap")
require("CarlG.treesitter")
require("CarlG.statusline")
require("CarlG.telescope")
require("CarlG.color")
require("CarlG.autocmd")

local keymap = require("CarlG.utils.keymap")
local map = keymap.map
local nmap = keymap.nmap
local noremap = keymap.noremap
local inoremap = keymap.inoremap
local nnoremap = keymap.nnoremap

nnoremap("<leader>a", function() require("harpoon.mark").add_file() end, {silent=true})
nnoremap("<C-e>", function() require("harpoon.ui").toggle_quick_menu() end, {silent=true})
nnoremap("<C-h>", function() require("harpoon.ui").nav_file(1) end)
nnoremap("<C-j>", function() require("harpoon.ui").nav_file(2) end)
nnoremap("<C-k>", function() require("harpoon.ui").nav_file(3) end)
nnoremap("<C-l>", function() require("harpoon.ui").nav_file(4) end)
