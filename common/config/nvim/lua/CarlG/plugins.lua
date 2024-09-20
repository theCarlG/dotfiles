--[[VIM PRE-PLUG]] 

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- https://github.com/wbthomason/packer.nvim#requirements
return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    --[ START PLUG ]
    --[[ Misc ]] 
    use 'christoomey/vim-tmux-navigator'
    use 'rhysd/conflict-marker.vim'
    use 'mg979/vim-visual-multi'
    use 'tpope/vim-obsession'
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup {}
        end
    }

    --[[ Neovim LSP Plugins ]]
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-buffer'},
            {'ray-x/lsp_signature.nvim',
                config = function()
                    -- Get signatures (and _only_ signatures) when in argument lists.
                    require "lsp_signature".setup({
                        doc_lines = 0,
                    })
                end
            },

            -- Snippets
            {'L3MON4D3/LuaSnip'},
        }
    }

    --[[ Treesitter ]] 
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-treesitter/nvim-treesitter-context'

    --[[ Themes ]]
    use 'gruvbox-community/gruvbox'

    --[[ Utilities ]] 
    use 'tpope/vim-fugitive'
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    --[[ Lualine ]] 
    use 'nvim-lualine/lualine.nvim'

    --[[ Telescope ]] 
    use { 'nvim-lua/popup.nvim', branch= 'master' }
    use { 'nvim-lua/plenary.nvim', branch= 'master' }
    use { 'nvim-lua/telescope.nvim', branch= 'master' }

    --[ END PLUG ]
    if packer_bootstrap then
        require('packer').sync()
    end
end)

