-- Miscellaneous plugins
return {
    -- Collaborative editing
    {
        "jbyuki/instant.nvim",
        cmd = { "InstantStartServer", "InstantJoinSession", "InstantStartSingle" },
    },
    
    -- RASI file support
    {
        "Fymyte/rasi.vim",
        ft = "rasi",
    },
    
    -- LazyDocker integration
    {
        "crnvl96/lazydocker.nvim",
        cmd = "LazyDocker",
        config = function()
            require("lazydocker").setup()
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
    },
    
    -- Laravel support
    {
        "adalessa/laravel.nvim",
        dependencies = {
            "tpope/vim-dotenv",
            "nvim-telescope/telescope.nvim",
            "MunifTanjim/nui.nvim",
            "kevinhwang91/promise-async",
        },
        cmd = { "Laravel" },
        keys = {
            { "<leader>la", ":Laravel artisan<cr>" },
            { "<leader>lr", ":Laravel routes<cr>" },
            { "<leader>lm", ":Laravel related<cr>" },
        },
        event = { "VeryLazy" },
        opts = {},
        config = true,
    },
    
    -- Blade template support
    {
        "jwalton512/vim-blade",
        ft = "blade",
    },
    
    -- Dotenv support
    {
        "tpope/vim-dotenv",
        lazy = true,
    },
    
    -- Database UI
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {
            { "tpope/vim-dadbod", lazy = true },
            { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
        },
        cmd = {
            "DBUI",
            "DBUIToggle",
            "DBUIAddConnection",
            "DBUIFindBuffer",
        },
        init = function()
            vim.g.db_ui_use_nerd_fonts = 1
        end,
    },
    
    -- Avante for note-taking
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        lazy = false,
        version = false,
        opts = {},
        build = "make",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
            {
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        use_absolute_path = true,
                    },
                },
            },
            {
                'MeanderingProgrammer/render-markdown.nvim',
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
    },
    
    -- Obsidian integration
    {
        "epwalsh/obsidian.nvim",
        version = "*",
        lazy = true,
        ft = "markdown",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {
            workspaces = {
                {
                    name = "personal",
                    path = "~/Documents/obsidian",
                },
            },
        },
    },
    
    -- LaTeX support
    {
        "lervag/vimtex",
        init = function()
            vim.g.vimtex_view_method = "zathura"
            vim.g.vimtex_compiler_latexmk = {
                options = {
                    "-verbose",
                    "-file-line-error",
                    "-synctex=1",
                    "-interaction=nonstopmode",
                    "-shell-escape",
                    "--output-directory=build",
                },
            }
        end,
        ft = "tex",
    },
}