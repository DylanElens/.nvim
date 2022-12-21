return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use "williamboman/nvim-lsp-installer"
    use "neovim/nvim-lspconfig"
    use 'nvim-lua/plenary.nvim'
    use 'jose-elias-alvarez/null-ls.nvim'

    use({ "kylechui/nvim-surround", tag = "*", config = function() require("nvim-surround").setup({}) end })
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'lervag/vimtex'
    use 'kdheepak/lazygit.nvim'

    use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install",
        setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })

    use { 'tpope/vim-dispatch', opt = true, cmd = { 'Dispatch', 'Make', 'Focus', 'Start' } }
    use { 'nvim-treesitter/nvim-treesitter' }
    use { 'lewis6991/gitsigns.nvim', config = function() require('gitsigns').setup() end }
    use { 'dracula/vim', as = 'dracula' }
    use 'nvim-telescope/telescope.nvim'
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use { "ellisonleao/gruvbox.nvim" }
    use 'kyazdani42/nvim-web-devicons'
    use { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end }
    use 'mrjones2014/smart-splits.nvim'
    use 'ThePrimeagen/harpoon'
    use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
    use({ "akinsho/toggleterm.nvim", commit = "aaeed9e02167c5e8f00f25156895a6fd95403af8" })
    use 'github/copilot.vim'
    use { "SmiteshP/nvim-navic", requires = "neovim/nvim-lspconfig" }
    use { 'sindrets/diffview.nvim' }
    use 'martinsione/darkplus.nvim'
    use "lunarvim/Onedarker.nvim"
    use 'mfussenegger/nvim-dap'
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
    use 'nanotee/sqls.nvim'
    use 'mfussenegger/nvim-dap-python'
    use 'aduros/ai.vim'
    use { "catppuccin/nvim", as = "catppuccin" }
    use { "zbirenbaum/copilot-cmp", after = { "copilot.lua" } }
end)
