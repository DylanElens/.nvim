-- Treesitter configuration
return {
    -- Treesitter for better syntax highlighting and code understanding
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
    },
    
    -- Hypr language support for Treesitter
    {
        "luckasRanarison/tree-sitter-hypr",
        ft = "hypr",
    },
}