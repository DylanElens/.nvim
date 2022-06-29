vim.g.mapleader = ' '
vim.opt.timeoutlen = 500

vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>fw", "<cmd>lua require('telescope.builtin').live_grep()<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", {})
vim.api.nvim_set_keymap("n", "<Left>", "<cmd>vertical resize +10<cr>", {})


vim.api.nvim_set_keymap("n", "<leader>h", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>af", "<cmd>lua require('harpoon.mark').add_file()<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>q", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>w", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>e", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>r", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", {})
