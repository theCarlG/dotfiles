local keymap = require("utils.keymap")
local nnoremap = keymap.nnoremap

nnoremap('<c-p>', "<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>")
nnoremap('<c-g>', function()
    require 'telescope.builtin'.git_files {}
end)
nnoremap("<c-F>", function()
    require('telescope.builtin').live_grep()
end)
nnoremap("<c-b>", function()
    require('telescope.builtin').buffers()
end)
nnoremap('gr', '<cmd>Telescope lsp_references<CR>')
nnoremap('gs', function()
    require 'telescope.builtin'.lsp_document_symbols { shorten_path = true }
end)

return {
    --[[ Telescope ]]
    {
        'nvim-lua/telescope.nvim',
        lazy = false,

        dependencies = {
            { 'nvim-lua/popup.nvim' },
            { 'nvim-lua/plenary.nvim' },
        },
        opts = {
            defaults = {
                file_ignore_patterns = {
                    "node_modules/.*",
                    "vendor/.*",
                    "build/.*",
                    "target/.*",
                    "[.]clangd/.*",
                    "[.].*/.*",
                },
                prompt_prefix = "   ",
                selection_caret = "  ",
                entry_prefix = "  ",
                initial_mode = "insert",
                selection_strategy = "reset",
                sorting_strategy = "ascending",
                set_env = { ['COLORTERM'] = 'truecolor' },
                vim_buffers_everywhere = true,
                grep_previewer = require 'telescope.previewers'.vim_buffer_vimgrep.new,
                qflist_previewer = require 'telescope.previewers'.vim_buffer_qflist.new,
                file_previewer = require 'telescope.previewers'.vim_buffer_cat.new,
                layout_strategy = "vertical",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        width = 0.8,
                        preview_width = 0.5,
                    },
                    vertical = {
                        width = 0.5,
                        height = 0.7,
                        preview_cutoff = 1,
                        prompt_position = "top",
                        preview_height = 0.4,
                        mirror = true,
                    },
                },
                pickers = {
                    buffers = {
                        mappings = {
                            -- n = { ["<c-d>"] = actions.delete_buffer },
                            -- i = { ["<c-d>"] = actions.delete_buffer },
                        },
                    },
                },
            }
        }

    },
}
