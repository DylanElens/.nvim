return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"SmiteshP/nvim-navic",
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
			"folke/neodev.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			require("neodev").setup()

			local navic = require("nvim-navic")

			local on_attach = function(client, bufnr)
				local attached_clients = vim.lsp.get_active_clients({ bufnr = bufnr })
				for _, existing_client in ipairs(attached_clients) do
					if existing_client.id ~= client.id and existing_client.name == client.name then
						return
					end
				end

				local bufopts = { noremap = true, silent = true, buffer = bufnr }

				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

				if client.server_capabilities.documentSymbolProvider then
					navic.attach(client, bufnr)
				end

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

				vim.keymap.set("n", "gK", vim.lsp.buf.hover, bufopts)
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

				-- Toggle inlay hints
				vim.keymap.set("n", "<leader>ih", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
				end, bufopts)

				-- Enable inlay hints if the client supports it
				if client.supports_method("textDocument/inlayHint") then
					vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
				end
			end

			-- Configure diagnostics globally (only once)
			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			})

			local lsp_flags = {
				debounce_text_changes = 150,
			}

			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

			-- Track which servers have been set up to prevent duplicates
			local setup_servers = {}

			-- Server configurations with specific settings
			local server_configs = {
				pyright = {},
				volar = {},
				ts_ls = {
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
						javascript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
					},
				},
				cssls = {},
				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							inlayHints = {
								bindingModeHints = {
									enable = true,
								},
								chainingHints = {
									enable = true,
								},
								closingBraceHints = {
									enable = true,
									minLines = 25,
								},
								closureReturnTypeHints = {
									enable = "always",
								},
								lifetimeElisionHints = {
									enable = "always",
									useParameterNames = false,
								},
								maxLength = 25,
								parameterHints = {
									enable = true,
								},
								reborrowHints = {
									enable = "always",
								},
								renderColons = true,
								typeHints = {
									enable = true,
									hideClosureInitialization = false,
									hideNamedConstructor = false,
								},
							},
						},
					},
				},
				gopls = {
					settings = {
						gopls = {
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
						},
					},
				},
				yamlls = {},
				hls = {},
				bashls = {},
				tailwindcss = {},
				clangd = {},
				jsonls = {},
				lua_ls = {
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
				},
				intelephense = {
					settings = {
						intelephense = {
							files = {
								maxSize = 1000000,
							},
							telemetry = {
								enabled = false,
							},
						},
					},
				},
			}

			for server_name, config in pairs(server_configs) do
				if not setup_servers[server_name] then
					local server_config = vim.tbl_deep_extend("force", {
						on_attach = on_attach,
						flags = lsp_flags,
						capabilities = capabilities,
					}, config)

					require("lspconfig")[server_name].setup(server_config)
					setup_servers[server_name] = true
				end
			end
		end,
	},

	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup({
				ui = {
					check_outdated_packages_on_open = true,
					border = "rounded",
				},
			})
		end,
	},

	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {},
				automatic_installation = false,
				automatic_setup = false,
				automatic_enable = false, -- Prevent duplicate LSP attachments
				handlers = nil,
			})
		end,
	},

	{
		"folke/neodev.nvim",
		opts = {},
	},

	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("lint").linters_by_ft = {
				php = { "phpstan", "php" },
			}

			vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},

	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					javascript = { "prettierd" },
					typescript = { "prettierd" },
					typescriptreact = { "prettierd" },
					lua = { "stylua" },
					php = { "pint" },
					go = { "golines" },
					latex = { "latexindent" },
				},
				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = false,
				},
			})
		end,
	},
}
