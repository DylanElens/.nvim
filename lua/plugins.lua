return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use "williamboman/nvim-lsp-installer"
    use "neovim/nvim-lspconfig"
    use 'nvim-lua/plenary.nvim'

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
    use "github/copilot.vim"
    use { "SmiteshP/nvim-navic", requires = "neovim/nvim-lspconfig" }
    use { 'sindrets/diffview.nvim' }
    use 'martinsione/darkplus.nvim'
    use "lunarvim/Onedarker.nvim"
    use 'mfussenegger/nvim-dap'
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
    use 'mfussenegger/nvim-dap-python'
    use { "williamboman/mason.nvim", run = ":MasonUpdate" }
    use { "catppuccin/nvim", as = "catppuccin" }
    use "williamboman/mason-lspconfig.nvim"
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'jwalton512/vim-blade'
    use 'tpope/vim-dotenv'
    use 'MunifTanjim/nui.nvim'
    use 'nvim-tree/nvim-tree.lua'

    use 'goolord/alpha-nvim'

    use {
        "rcarriga/nvim-notify",
        config = function()
            local notify = require("notify")
            -- this for transparency
            notify.setup({ background_colour = "#000000" })
            -- this overwrites the vim notify function
            vim.notify = notify.notify
        end
    }

    use {
        'adalessa/laravel.nvim',
        requires = {
            'nvim-telescope/telescope.nvim',
            'tpope/vim-dotenv',
            'MunifTanjim/nui.nvim',
        },
        cmd = { 'Sail', 'Artisan', 'Composer', 'Npm', 'Yarn', 'Laravel' },
        keys = {
            { 'n', '<leader>la', ':Laravel artisan<cr>', {
                noremap = true,
                silent = true
            } },
            { 'n', '<leader>lr', ':Laravel routes<cr>', {
                noremap = true,
                silent = true
            } },
            { 'v', '<leader>lt', '<cmd>lua require("laravel.tinker").send_to_tinker()<cr>',
                {
                    noremap = true,
                    silent = true,
                    description = "Laravel Application Routes"
                } },
        },
        event = 'VimEnter',
        config = function()
            require('laravel').setup()
            require('telescope').load_extension('laravel')
        end,
    }

    use { 'alexghergh/nvim-tmux-navigation', config = function()
        local nvim_tmux_nav = require('nvim-tmux-navigation')

        nvim_tmux_nav.setup {
            disable_when_zoomed = true -- defaults to false
        }

        vim.keymap.set('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
        vim.keymap.set('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
        vim.keymap.set('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
        vim.keymap.set('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
        vim.keymap.set('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
        vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
    end
    }
    -- packer example:
    use {
        "LunarVim/bigfile.nvim",
    }
end)
