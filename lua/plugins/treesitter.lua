-- Treesitter configuration
return {
    -- Treesitter for better syntax highlighting and code understanding
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            })
        end,
    },
    
    -- Hypr language support for Treesitter
    {
        "luckasRanarison/tree-sitter-hypr",
        ft = "hypr",
    },
}