return {
	"ellisonleao/gruvbox.nvim",
	name = "gruvbox",
	priority = 1000,
	config = function()
		require("gruvbox").setup({
			contrast = "",
			transparent_mode = false,
		})

		vim.cmd.colorscheme("gruvbox")
	end,
}
