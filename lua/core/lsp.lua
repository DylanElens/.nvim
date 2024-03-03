-- Setup Mason and Mason LSP Config
require("mason").setup()
require("mason-lspconfig").setup()

-- Setup nvim-navic
local navic = require("nvim-navic")

-- Keymap Options
local opts = { noremap = true, silent = true }

-- Diagnostic keymaps
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- LSP on_attach function
local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	if client.name ~= "null-ls" then
		navic.attach(client, bufnr)
	end

	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	-- LSP keymaps
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	-- // I want to see a big preview
	-- use telescope for definition if there are multiple results
	-- decrease the size of the results window
	vim.keymap.set("n", "gd", function()
		require("telescope.builtin").lsp_definitions({
			layout_strategy = "vertical",
			layout_config = {
				width = 0.9,
				height = 0.9,
				prompt_position = "top",
			},
		})
	end, bufopts)
	vim.keymap.set("n", "gl", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	-- vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "gr", function()
		require("telescope.builtin").lsp_references({
			layout_strategy = "vertical",
			layout_config = {
				width = 0.9,
				height = 0.9,
				prompt_position = "top",
			},
		})
	end, bufopts)
	vim.keymap.set("n", "gl", function()
		vim.diagnostic.open_float()
	end, bufopts)
end

-- LSP flags
local lsp_flags = {
	debounce_text_changes = 150,
}

-- Linter Configuration
local jsfiletypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
local jslinter = { "eslint_d" }
local ft_configs = {}

local phpFiletypes = { "php" }
local phplinter = { "phpstan" }

for _, value in pairs(phpFiletypes) do
	ft_configs[value] = phplinter
end

for _, value in pairs(jsfiletypes) do
	ft_configs[value] = jslinter
end

require("lint").linters_by_ft = ft_configs

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

-- Common capabilities for LSP servers
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- LSP server configurations
local servers = {
	"pyright",
	"volar",
	"tsserver",
	"rust_analyzer",
	"intelephense",
	"yamlls",
	"hls",
	"bashls",
	"tailwindcss",
	"clangd",
}
for _, lsp in ipairs(servers) do
	require("lspconfig")[lsp].setup({
		on_attach = on_attach,
		flags = lsp_flags,
		capabilities = capabilities,
	})
end

-- Special configuration for lua_ls
require("lspconfig")["lua_ls"].setup({
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
})
