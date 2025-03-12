-- Coding tools and utilities
return {
    -- Comment code
    {
        "numToStr/Comment.nvim",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("Comment").setup()
        end,
    },
    
    -- File navigation
    {
        "ThePrimeagen/harpoon",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    
    -- AI code completion
    {
        "github/copilot.vim",
        event = "InsertEnter",
    },
    
    -- Copilot chat
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        event = "VeryLazy",
        opts = {
            show_help = "yes",
            debug = false,
            disable_extra_info = "no",
            language = "English",
        },
        build = function()
            vim.notify("Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim.")
        end,
        keys = {
            { "<leader>ccb", ":CopilotChatBuffer ", desc = "CopilotChat - Chat with current buffer" },
            { "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
            { "<leader>cct", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
            { "<leader>ccT", "<cmd>CopilotChatVsplitToggle<cr>", desc = "CopilotChat - Toggle Vsplit" },
            { "<leader>ccv", ":CopilotChatVisual ", mode = "x", desc = "CopilotChat - Open in vertical split" },
            { "<leader>ccx", ":CopilotChatInPlace<cr>", mode = "x", desc = "CopilotChat - Run in-place code" },
            { "<leader>ccf", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "CopilotChat - Fix diagnostic" },
            { "<leader>ccr", "<cmd>CopilotChatReset<cr>", desc = "CopilotChat - Reset chat history and clear buffer" },
        },
    },
    
    -- Vim dispatch for async commands
    {
        "tpope/vim-dispatch",
        cmd = { "Dispatch", "Make", "Focus", "Start" },
    },
    
    -- Debugging
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            {
                "rcarriga/nvim-dap-ui",
                dependencies = { "mfussenegger/nvim-dap" },
            },
            "mfussenegger/nvim-dap-python",
        },
        cmd = { 
            "DapToggleBreakpoint", 
            "DapContinue", 
            "DapStepOver", 
            "DapStepInto", 
            "DapStepOut",
            "DapTerminate" 
        },
    },
    
    -- Debug UI
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        cmd = { "DapUIToggle", "DapUIOpen", "DapUIClose" },
    },
    
    -- Python DAP
    {
        "mfussenegger/nvim-dap-python",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        ft = "python",
    },
}