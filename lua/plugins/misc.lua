return {
	{
		"Fymyte/rasi.vim",
		ft = "rasi",
	},
	{
		"crnvl96/lazydocker.nvim",
		cmd = "LazyDocker",
		config = function()
			require("lazydocker").setup()
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"jwalton512/vim-blade",
		ft = "blade",
	},
	{
		"tpope/vim-dotenv",
		lazy = true,
	},
}
