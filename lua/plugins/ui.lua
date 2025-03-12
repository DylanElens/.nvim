-- UI enhancements
return {
    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = {
            "kyazdani42/nvim-web-devicons",
        },
    },
    
    -- Dashboard
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
    },
    
    -- File explorer
    {
        "nvim-tree/nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        dependencies = {
            "kyazdani42/nvim-web-devicons",
        },
    },
    
    -- Better UI elements
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
    },
    
    -- Terminal integration
    {
        "akinsho/toggleterm.nvim",
        cmd = "ToggleTerm",
        version = "*",
    },
    
    -- Smart window splits
    {
        "mrjones2014/smart-splits.nvim",
        lazy = true,
    },
    
    -- TMUX integration
    {
        "alexghergh/nvim-tmux-navigation",
        event = "VeryLazy",
        config = function()
            local nvim_tmux_nav = require("nvim-tmux-navigation")

            nvim_tmux_nav.setup({
                disable_when_zoomed = true,
            })

            vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
            vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
            vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
            vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
            vim.keymap.set("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
            vim.keymap.set("n", "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
        end,
    },
    
    -- Colorschemes
    { "martinsione/darkplus.nvim", lazy = true },
    { "lunarvim/Onedarker.nvim", lazy = true },
    { "catppuccin/nvim", name = "catppuccin", lazy = true },
}