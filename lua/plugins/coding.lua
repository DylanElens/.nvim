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
        keys = {
            { "<leader>h", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Harpoon menu" },
            { "<leader>af", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Add to harpoon" },
            { "<leader>1", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", desc = "Harpoon file 1" },
            { "<leader>2", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", desc = "Harpoon file 2" },
            { "<leader>3", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", desc = "Harpoon file 3" },
            { "<leader>4", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", desc = "Harpoon file 4" },
            { "<leader>5", "<cmd>lua require('harpoon.ui').nav_file(5)<cr>", desc = "Harpoon file 5" },
            { "<leader>6", "<cmd>lua require('harpoon.ui').nav_file(6)<cr>", desc = "Harpoon file 6" },
        },
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
        keys = {
            { "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", desc = "Toggle breakpoint" },
            { "<leader>dc", "<cmd>lua require'dap'.continue()<CR>", desc = "Continue" },
            { "<leader>di", "<cmd>lua require'dap'.step_into()<CR>", desc = "Step into" },
            { "<leader>do", "<cmd>lua require'dap'.step_over()<CR>", desc = "Step over" },
            { "<leader>dr", "<cmd>lua require'dap'.repl.open()<CR>", desc = "Open REPL" },
            { "<leader>dl", "<cmd>lua require'dap'.run_last()<CR>", desc = "Run last" },
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
        keys = {
            { "<leader>du", "<cmd>lua require'dapui'.open()<CR>", desc = "Open DAP UI" },
            { "<leader>dh", "<cmd>lua require'dapui'.eval()<CR>", mode = "v", desc = "Evaluate selection" },
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