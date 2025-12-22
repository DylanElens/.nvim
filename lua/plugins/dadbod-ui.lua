return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql", "postgres" }, lazy = true },
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	keys = {
		{ "<leader>db", "<cmd>DBUIToggle<cr>", desc = "Toggle DB UI" },
		{ "<leader>df", "<cmd>DBUIFindBuffer<cr>", desc = "Find DB buffer" },
		{ "<leader>da", "<cmd>DBUIAddConnection<cr>", desc = "Add DB connection" },
	},
	init = function()
		vim.g.db_ui_use_nerd_fonts = 1
		vim.g.db_ui_winwidth = 40
		vim.g.db_ui_use_postgres_views = 1
		vim.g.db_ui_auto_execute_table_helpers = 1
		vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"
	end,
	config = function()
		local autocomplete = require("cmp")
		autocomplete.setup.filetype({ "sql", "mysql", "plsql", "postgres" }, {
			sources = {
				{ name = "vim-dadbod-completion" },
				{ name = "buffer" },
			},
		})
	end,
}
