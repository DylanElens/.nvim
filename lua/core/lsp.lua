-- Setup Mason and Mason LSP Config
require("mason").setup()
require("mason-lspconfig").setup()
require("neodev").setup()

local navic = require("nvim-navic")

local on_attach = function(client, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	navic.attach(client, bufnr)

	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
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

local lsp_flags = {
	debounce_text_changes = 150,
}

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local servers = {
	"pyright",
	"volar",
	"tsserver",
	"rust_analyzer",
	"intelephense",
	"gopls",
	"yamlls",
	"hls",
	"bashls",
	"tailwindcss",
	"clangd",
	"jsonls",
	"yamlls",
}

for _, lsp in ipairs(servers) do
	require("lspconfig")[lsp].setup({
		on_attach = on_attach,
		flags = lsp_flags,
		capabilities = capabilities,
	})
end

require("lspconfig").lua_ls.setup({
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
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
