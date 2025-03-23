-- LSP Configuration
return {
    -- LSP Configuration
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "SmiteshP/nvim-navic", -- LSP breadcrumbs
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "folke/neodev.nvim", -- Better Lua LSP for Neovim configuration
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
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
                "ts_ls",
                "cssls",
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
                -- "java_language_server",
            }
            
            for _, lsp in ipairs(servers) do
                require("lspconfig")[lsp].setup({
                    on_attach = on_attach,
                    flags = lsp_flags,
                    capabilities = capabilities,
                })
            end
            
            require("lspconfig").lua_ls.setup({
                on_attach = on_attach,
                flags = lsp_flags,
                capabilities = capabilities,
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
        end,
    },
    
    -- Mason for LSP, DAP, formatters, linters
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        build = ":MasonUpdate",
        config = function()
            require("mason").setup()
        end,
    },
    
    -- Bridge between Mason and LSP config
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            require("mason-lspconfig").setup()
        end,
    },
    
    -- Better Lua LSP for Neovim configuration  
    {
        "folke/neodev.nvim",
        opts = {},
    },
    
    -- Linting
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            -- Auto commands for linting
            vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
                callback = function()
                    require("lint").try_lint()
                end,
            })
        end,
    },
    
    -- Formatting
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
    
    -- Null-ls
    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
}
