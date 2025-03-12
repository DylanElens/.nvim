-- Completion and snippets
return {
    -- Completion plugin
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",    -- LSP source for nvim-cmp
            "hrsh7th/cmp-buffer",      -- Buffer source for nvim-cmp
            "hrsh7th/cmp-path",        -- Path source for nvim-cmp
            "hrsh7th/cmp-cmdline",     -- Cmdline source for nvim-cmp
            "saadparwaiz1/cmp_luasnip", -- Luasnip source for nvim-cmp
            "L3MON4D3/LuaSnip",        -- Snippet engine
        },
    },
    
    -- Snippet engine
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "evesdropper/luasnip-latex-snippets.nvim", -- LaTeX snippets
        },
        event = "InsertEnter",
    },
    
    -- Sources for nvim-cmp
    { "hrsh7th/cmp-nvim-lsp", lazy = true },
    { "hrsh7th/cmp-buffer", lazy = true },
    { "hrsh7th/cmp-path", lazy = true },
    { "hrsh7th/cmp-cmdline", lazy = true },
    { "saadparwaiz1/cmp_luasnip", lazy = true },

    -- LaTeX snippets
    {
        "evesdropper/luasnip-latex-snippets.nvim",
        lazy = true,
        ft = { "tex", "latex" },
    },

    -- SQL completion
    {
        "kristijanhusak/vim-dadbod-completion",
        lazy = true,
        ft = { "sql", "mysql", "plsql" },
    },
}