-- Git integration
return {
    -- Git signs in the gutter
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("gitsigns").setup({
                current_line_blame = true,
            })
        end,
    },
    
    -- LazyGit integration
    {
        "kdheepak/lazygit.nvim",
        cmd = "LazyGit",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    
    -- Git diff view
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
}