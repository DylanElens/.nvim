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
        },
    },
    
    -- Mason for LSP, DAP, formatters, linters
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        build = ":MasonUpdate",
    },
    
    -- Bridge between Mason and LSP config
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
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
    },
    
    -- Formatting
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
    },
    
    -- Null-ls
    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
}