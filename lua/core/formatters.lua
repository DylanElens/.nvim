-- Formatter Configuration
require("conform").setup({
	formatters_by_ft = {
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		typescriptreact = { "prettierd" },
		lua = { "stylua" },
		php = { "pint" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = false,
	},
})

-- Auto commands for linting
vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
