return {
	{
		"ThePrimeagen/harpoon",
		event = "VeryLazy",
		keys = {
			{ "<leader>h", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Harpoon menu" },
			{ "<leader>af", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Add to harpoon" },
			{ "<leader>1", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", desc = "Harpoon file 1" },
			{ "<leader>2", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", desc = "Harpoon file 2" },
			{ "<leader>3", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", desc = "Harpoon file 3" },
			{ "<leader>4", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", desc = "Harpoon file 4" },
			{ "<leader>5", "<cmd>lua require('harpoon.ui').nav_file(5)<cr>", desc = "Harpoon file 5" },
			{ "<leader>6", "<cmd>lua require('harpoon.ui').nav_file(6)<cr>", desc = "Harpoon file 6" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"tpope/vim-dispatch",
		cmd = { "Dispatch", "Make", "Focus", "Start" },
	},
	{ "blazkowolf/gruber-darker.nvim" },
}
