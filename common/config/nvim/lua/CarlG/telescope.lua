local telescope = require("telescope")
telescope.setup{
    defaults = {
        file_ignore_patterns = {
            "node_modules/.*",
            "vendor/.*",
            "build/.*",
            "target/.*",
            "[.]clangd/.*",
            "[.].*/.*",
        },
        set_env = { ['COLORTERM'] = 'truecolor' },
        vim_buffers_everywhere = true,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        layout_strategy = "vertical",
        layout_config = {
            width = 0.70,
            height = 0.70,
            preview_cutoff = 40,
        },
    }
}

local keymap = require("CarlG.utils.keymap")
local nnoremap = keymap.nnoremap

nnoremap('<c-p>', "<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>")
nnoremap('<c-g>', function()
    require'telescope.builtin'.git_files{}
end)
nnoremap("<c-b>", function()
    require('telescope.builtin').buffers()
end)
nnoremap('gr', function()
    require'telescope.builtin'.lsp_references{ shorten_path = true }
end)
nnoremap('gy', function()
    require'telescope.builtin'.lsp_document_symbols{ shorten_path = true }
end)
