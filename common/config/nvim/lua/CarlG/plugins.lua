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

    --[[ Debugger ]] 
    use {'mfussenegger/nvim-dap', 
        requires = {
            { "nvim-neotest/nvim-nio" }
        }
    }


    use 'leoluz/nvim-dap-go'
    use 'rcarriga/nvim-dap-ui'
    use 'theHamsta/nvim-dap-virtual-text'

    --[[ Neovim LSP Plugins ]] 
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},
            {'jayp0521/mason-nvim-dap.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            -- Snippet Collection (Optional)
            {'rafamadriz/friendly-snippets'},
        }
    }

    --[[ Treesitter ]] 
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'LhKipp/nvim-nu', run = ':TSInstall nu' }
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

