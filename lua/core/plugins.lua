local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
	"williamboman/nvim-lsp-installer",
	"neovim/nvim-lspconfig",
	"nvim-lua/plenary.nvim",

	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",
	"SmiteshP/nvim-navic",
	"mfussenegger/nvim-lint",
	"kdheepak/lazygit.nvim",
	"stevearc/conform.nvim",
	{
		"crnvl96/lazydocker.nvim",
		config = function()
			require("lazydocker").setup()
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},
	{ "tpope/vim-dispatch", cmd = { "Dispatch", "Make", "Focus", "Start" } },
	{ "nvim-treesitter/nvim-treesitter" },
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	"nvim-telescope/telescope.nvim",
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	"kyazdani42/nvim-web-devicons",
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	"mrjones2014/smart-splits.nvim",
	"ThePrimeagen/harpoon",
	{ "nvim-lualine/lualine.nvim", dependencies = { "kyazdani42/nvim-web-devicons" } },
	{ "akinsho/toggleterm.nvim", commit = "aaeed9e02167c5e8f00f25156895a6fd95403af8" },
	"github/copilot.vim",
	{ "sindrets/diffview.nvim" },
	"martinsione/darkplus.nvim",
	"lunarvim/Onedarker.nvim",
	"mfussenegger/nvim-dap",
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
	"mfussenegger/nvim-dap-python",
	{ "williamboman/mason.nvim" },
	"catppuccin/nvim",
	"williamboman/mason-lspconfig.nvim",
	"jose-elias-alvarez/null-ls.nvim",
	"jwalton512/vim-blade",
	"tpope/vim-dotenv",
	"MunifTanjim/nui.nvim",
	"nvim-tree/nvim-tree.lua",
	"folke/noice.nvim",
	"jbyuki/instant.nvim",
	"luckasRanarison/tree-sitter-hypr",
	{
		"Fymyte/rasi.vim",
		ft = "rasi",
	},
	"goolord/alpha-nvim",
	{
		"alexghergh/nvim-tmux-navigation",
		config = function()
			local nvim_tmux_nav = require("nvim-tmux-navigation")

			nvim_tmux_nav.setup({
				disable_when_zoomed = true, -- defaults to false
			})

			vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
			vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
			vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
			vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
			vim.keymap.set("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
			vim.keymap.set("n", "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
		end,
	},
	{
		"jackMort/ChatGPT.nvim",
		config = function()
			require("chatgpt").setup()
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"folke/trouble.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	{ "folke/neodev.nvim", opts = {} },
}

require("lazy").setup(plugins, {})
