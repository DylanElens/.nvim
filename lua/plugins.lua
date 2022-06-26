return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use "williamboman/nvim-lsp-installer"
  use "neovim/nvim-lspconfig"
  use 'nvim-lua/plenary.nvim'

  use 'jose-elias-alvarez/null-ls.nvim'

  use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}
  use {'andymass/vim-matchup', event = 'VimEnter'}
  use {'haorenW1025/completion-nvim', opt = true, requires = {{'hrsh7th/vim-vsnip', opt = true}, {'hrsh7th/vim-vsnip-integ', opt = true}}}
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'lewis6991/gitsigns.nvim'
  use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}
  use {'dracula/vim', as = 'dracula'}

end)

