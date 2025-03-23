-- Bootstrap lazy.nvim
require("core.plugins")

-- Core settings
require("core.options")
require("core.keys")

-- Features
require("core.completion")
require("core.bar")
require("core.topbar")
require("core.navigation")
require("core.linters")

-- Note: The following configurations have been moved to plugin files:
-- - treesitter → lua/plugins/treesitter.lua
-- - telescopes → lua/plugins/telescope.lua
-- - tree → lua/plugins/ui.lua (nvim-tree)
-- - superalpha → lua/plugins/ui.lua (alpha-nvim)
-- - smartsplits → lua/plugins/ui.lua (smart-splits)
-- - toggleterminal → lua/plugins/ui.lua (toggleterm)
-- - lazygitstuff → lua/plugins/git.lua (lazygit configuration)
-- - gitsigns config → lua/plugins/git.lua
-- - noice config → lua/plugins/ui.lua
-- - colorscheme → lua/plugins/ui.lua (catppuccin configuration)
-- - lsp → lua/plugins/lsp.lua (LSP configuration)
-- - formatters → lua/plugins/lsp.lua (conform.nvim configuration)
