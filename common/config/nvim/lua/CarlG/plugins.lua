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
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/nvim-cmp'
    use 'nvim-lua/lsp_extensions.nvim'
    use 'onsails/lspkind-nvim'
    use 'simrat39/symbols-outline.nvim'

    --[[ Snippets ]] 
    use 'L3MON4D3/luasnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'rafamadriz/friendly-snippets'

    --[[ Treesitter ]] 
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-treesitter/nvim-treesitter-context'

    --[[ Themes ]]
    use 'gruvbox-community/gruvbox'

    --[[ Utilities ]] 
    use 'editorconfig/editorconfig-vim'
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
    use 'ThePrimeagen/harpoon'

    --[[ Debugger ]] 
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'
    use 'theHamsta/nvim-dap-virtual-text'

    --[[ Lualine ]] 
    use 'nvim-lualine/lualine.nvim'

    --[[ Telescope ]] 
    use { 'nvim-lua/popup.nvim', branch= 'master' }
    use { 'nvim-lua/plenary.nvim', branch= 'master' }
    use { 'nvim-lua/telescope.nvim', branch= 'master' }

    --[[ Notes ]]
    use 'ixru/nvim-markdown'
    use 'elzr/vim-json'
    use 'cespare/vim-toml'
    use 'ellisonleao/glow.nvim'
    use 'jghauser/follow-md-links.nvim'

    --[ END PLUG ]
    if packer_bootstrap then
        require('packer').sync()
    end
end)

