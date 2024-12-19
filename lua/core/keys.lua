vim.g.mapleader = ' '
vim.opt.timeoutlen = 500

--telescope
vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>fw", "<cmd>lua require('telescope.builtin').live_grep()<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", {})
vim.api.nvim_set_keymap("n", "<Left>", "<cmd>vertical resize +10<cr>", {})

--harpoon
vim.api.nvim_set_keymap("n", "<leader>h", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>af", "<cmd>lua require('harpoon.mark').add_file()<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>1", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>2", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>3", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>4", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>5", "<cmd>lua require('harpoon.ui').nav_file(5)<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>6", "<cmd>lua require('harpoon.ui').nav_file(6)<cr>", {})

vim.api.nvim_set_keymap("n", "<leader>a", "<cmd>AvanteAsk<cr>", {})

--toggle terminal
vim.api.nvim_set_keymap("n", "<leader>td", "<cmd>lua _GOBANG_TOGGLE()<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>th", "<cmd>lua _HTOP_TOGGLE()<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>tn", "<cmd>lua _NODE_TOGGLE()<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>cd", "<cmd>lua _PYTHON_TOGGLE()<CR>", {})

--Git stuff
vim.api.nvim_set_keymap("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>gc", "<cmd>DiffviewClose<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>LazyGit<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>ct", "<cmd>Copilot enable<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>cf", "<cmd>Copilot disable<CR>", {})

--Debugging
vim.api.nvim_set_keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.open()<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>du", "<cmd>lua require'dapui'.open()<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>dh", "<cmd>lua require'dapui'.eval(<expression>)<CR>", {})
vim.api.nvim_set_keymap("v", "<leader>dh", "<cmd>lua require'dapui'.eval()<CR>", {})



--tree
vim.api.nvim_set_keymap("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<cr>", {})
--always enable blame_line
require('gitsigns').setup {
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
}

require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
})
