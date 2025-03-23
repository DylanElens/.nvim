vim.g.mapleader = ' '
vim.opt.timeoutlen = 500

-- Avante key
vim.api.nvim_set_keymap("n", "<leader>a", "<cmd>AvanteAsk<cr>", {})

-- Copilot keys
vim.api.nvim_set_keymap("n", "<leader>ct", "<cmd>Copilot enable<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>cf", "<cmd>Copilot disable<CR>", {})

-- Note: All other keys have been moved to their respective plugin files:
-- - Telescope keys are in lua/plugins/telescope.lua
-- - Nvim-tree keys are in lua/plugins/ui.lua
-- - Toggleterm keys are in lua/plugins/ui.lua
-- - Git keys are in lua/plugins/git.lua

-- The following plugins' configs have been moved:
-- - Gitsigns -> to lua/plugins/git.lua
-- - Noice -> to lua/plugins/ui.lua
