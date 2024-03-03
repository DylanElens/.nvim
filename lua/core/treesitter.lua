require("nvim-treesitter.configs").setup({

	ensure_installed = { "javascript", "typescript", "c", "rust", "python" },
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = 1000,
	},

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.hypr = {
	install_info = {
		url = "https://github.com/luckasRanarison/tree-sitter-hypr",
		files = { "src/parser.c" },
		branch = "master",
	},
	filetype = "hypr",
}
