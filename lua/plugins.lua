return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use "williamboman/nvim-lsp-installer"
  use "neovim/nvim-lspconfig"
  use 'nvim-lua/plenary.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}
  use {'andymass/vim-matchup', event = 'VimEnter'}
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'lewis6991/gitsigns.nvim'
  use {'dracula/vim', as = 'dracula'}
  use 'nvim-telescope/telescope.nvim'
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
end)

