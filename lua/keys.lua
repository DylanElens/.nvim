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
vim.api.nvim_set_keymap("n", "<leader>q", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>w", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>e", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>r", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", {})

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
