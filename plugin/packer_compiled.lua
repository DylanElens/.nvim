-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/dylan/.cache/nvim/packer_hererocks/2.1.1702233742/share/lua/5.1/?.lua;/home/dylan/.cache/nvim/packer_hererocks/2.1.1702233742/share/lua/5.1/?/init.lua;/home/dylan/.cache/nvim/packer_hererocks/2.1.1702233742/lib/luarocks/rocks-5.1/?.lua;/home/dylan/.cache/nvim/packer_hererocks/2.1.1702233742/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/dylan/.cache/nvim/packer_hererocks/2.1.1702233742/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0" },
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["Onedarker.nvim"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/Onedarker.nvim",
    url = "https://github.com/lunarvim/Onedarker.nvim"
  },
  ["alpha-nvim"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/alpha-nvim",
    url = "https://github.com/goolord/alpha-nvim"
  },
  ["bigfile.nvim"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/bigfile.nvim",
    url = "https://github.com/LunarVim/bigfile.nvim"
  },
  catppuccin = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/catppuccin",
    url = "https://github.com/catppuccin/nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["copilot.vim"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/copilot.vim",
    url = "https://github.com/github/copilot.vim"
  },
  ["darkplus.nvim"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/darkplus.nvim",
    url = "https://github.com/martinsione/darkplus.nvim"
  },
  ["diffview.nvim"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  dracula = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/dracula",
    url = "https://github.com/dracula/vim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["gruvbox.nvim"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/gruvbox.nvim",
    url = "https://github.com/ellisonleao/gruvbox.nvim"
  },
  harpoon = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/harpoon",
    url = "https://github.com/ThePrimeagen/harpoon"
  },
  ["instant.nvim"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/instant.nvim",
    url = "https://github.com/jbyuki/instant.nvim"
  },
  ["laravel.nvim"] = {
    commands = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
    config = { "\27LJ\2\nf\0\0\3\0\5\0\f6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\0029\0\4\0'\2\1\0B\0\2\1K\0\1\0\19load_extension\14telescope\nsetup\flaravel\frequire\0" },
    keys = { { "n", "<leader>la", ":Laravel artisan<cr>", {
          noremap = true,
          silent = true
        } }, { "n", "<leader>lr", ":Laravel routes<cr>", {
          noremap = true,
          silent = true
        } }, { "v", "<leader>lt", '<cmd>lua require("laravel.tinker").send_to_tinker()<cr>', {
          description = "Laravel Application Routes",
          noremap = true,
          silent = true
        } } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/opt/laravel.nvim",
    url = "https://github.com/adalessa/laravel.nvim"
  },
  ["lazydocker.nvim"] = {
    config = { "\27LJ\2\n8\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\15lazydocker\frequire\0" },
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/lazydocker.nvim",
    url = "https://github.com/crnvl96/lazydocker.nvim"
  },
  ["lazygit.nvim"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/lazygit.nvim",
    url = "https://github.com/kdheepak/lazygit.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["noice.nvim"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/noice.nvim",
    url = "https://github.com/folke/noice.nvim"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-python"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/nvim-dap-python",
    url = "https://github.com/mfussenegger/nvim-dap-python"
  },
  ["nvim-dap-ui"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-navic"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/nvim-navic",
    url = "https://github.com/SmiteshP/nvim-navic"
  },
  ["nvim-surround"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18nvim-surround\frequire\0" },
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/nvim-surround",
    url = "https://github.com/kylechui/nvim-surround"
  },
  ["nvim-tmux-navigation"] = {
    config = { "\27LJ\2\nÂ\3\0\0\6\0\20\00016\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0B\1\2\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\b\0009\5\t\0B\1\4\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\n\0009\5\v\0B\1\4\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\f\0009\5\r\0B\1\4\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\14\0009\5\15\0B\1\4\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\16\0009\5\17\0B\1\4\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\18\0009\5\19\0B\1\4\1K\0\1\0\25NvimTmuxNavigateNext\14<C-Space>\31NvimTmuxNavigateLastActive\n<C-\\>\26NvimTmuxNavigateRight\n<C-l>\23NvimTmuxNavigateUp\n<C-k>\25NvimTmuxNavigateDown\n<C-j>\25NvimTmuxNavigateLeft\n<C-h>\6n\bset\vkeymap\bvim\1\0\1\24disable_when_zoomed\2\nsetup\25nvim-tmux-navigation\frequire\0" },
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/nvim-tmux-navigation",
    url = "https://github.com/alexghergh/nvim-tmux-navigation"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/nvim-tree/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["rasi.vim"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/opt/rasi.vim",
    url = "https://github.com/Fymyte/rasi.vim"
  },
  ["smart-splits.nvim"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/smart-splits.nvim",
    url = "https://github.com/mrjones2014/smart-splits.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["toggleterm.nvim"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  ["tree-sitter-hypr"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/tree-sitter-hypr",
    url = "https://github.com/luckasRanarison/tree-sitter-hypr"
  },
  ["vim-blade"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/vim-blade",
    url = "https://github.com/jwalton512/vim-blade"
  },
  ["vim-dispatch"] = {
    commands = { "Dispatch", "Make", "Focus", "Start" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/opt/vim-dispatch",
    url = "https://github.com/tpope/vim-dispatch"
  },
  ["vim-dotenv"] = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/vim-dotenv",
    url = "https://github.com/tpope/vim-dotenv"
  },
  vimtex = {
    loaded = true,
    path = "/home/dylan/.local/share/nvim/site/pack/packer/start/vimtex",
    url = "https://github.com/lervag/vimtex"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-surround
time([[Config for nvim-surround]], true)
try_loadstring("\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18nvim-surround\frequire\0", "config", "nvim-surround")
time([[Config for nvim-surround]], false)
-- Config for: nvim-tmux-navigation
time([[Config for nvim-tmux-navigation]], true)
try_loadstring("\27LJ\2\nÂ\3\0\0\6\0\20\00016\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0B\1\2\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\b\0009\5\t\0B\1\4\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\n\0009\5\v\0B\1\4\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\f\0009\5\r\0B\1\4\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\14\0009\5\15\0B\1\4\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\16\0009\5\17\0B\1\4\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\18\0009\5\19\0B\1\4\1K\0\1\0\25NvimTmuxNavigateNext\14<C-Space>\31NvimTmuxNavigateLastActive\n<C-\\>\26NvimTmuxNavigateRight\n<C-l>\23NvimTmuxNavigateUp\n<C-k>\25NvimTmuxNavigateDown\n<C-j>\25NvimTmuxNavigateLeft\n<C-h>\6n\bset\vkeymap\bvim\1\0\1\24disable_when_zoomed\2\nsetup\25nvim-tmux-navigation\frequire\0", "config", "nvim-tmux-navigation")
time([[Config for nvim-tmux-navigation]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: lazydocker.nvim
time([[Config for lazydocker.nvim]], true)
try_loadstring("\27LJ\2\n8\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\15lazydocker\frequire\0", "config", "lazydocker.nvim")
time([[Config for lazydocker.nvim]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.api.nvim_create_user_command, 'Dispatch', function(cmdargs)
          require('packer.load')({'vim-dispatch'}, { cmd = 'Dispatch', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'vim-dispatch'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('Dispatch ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'Make', function(cmdargs)
          require('packer.load')({'vim-dispatch'}, { cmd = 'Make', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'vim-dispatch'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('Make ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'Focus', function(cmdargs)
          require('packer.load')({'vim-dispatch'}, { cmd = 'Focus', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'vim-dispatch'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('Focus ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'Start', function(cmdargs)
          require('packer.load')({'vim-dispatch'}, { cmd = 'Start', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'vim-dispatch'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('Start ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'Sail', function(cmdargs)
          require('packer.load')({'laravel.nvim'}, { cmd = 'Sail', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'laravel.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('Sail ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'Artisan', function(cmdargs)
          require('packer.load')({'laravel.nvim'}, { cmd = 'Artisan', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'laravel.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('Artisan ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'Composer', function(cmdargs)
          require('packer.load')({'laravel.nvim'}, { cmd = 'Composer', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'laravel.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('Composer ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'Npm', function(cmdargs)
          require('packer.load')({'laravel.nvim'}, { cmd = 'Npm', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'laravel.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('Npm ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'Yarn', function(cmdargs)
          require('packer.load')({'laravel.nvim'}, { cmd = 'Yarn', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'laravel.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('Yarn ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'Laravel', function(cmdargs)
          require('packer.load')({'laravel.nvim'}, { cmd = 'Laravel', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'laravel.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('Laravel ', 'cmdline')
      end})
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[nnoremap <silent> <leader>la <cmd>lua require("packer.load")({'laravel.nvim'}, { keys = "<lt>leader>la", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[vnoremap <silent> <leader>lt <cmd>lua require("packer.load")({'laravel.nvim'}, { keys = "<lt>leader>lt", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>lr <cmd>lua require("packer.load")({'laravel.nvim'}, { keys = "<lt>leader>lr", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType rasi ++once lua require("packer.load")({'rasi.vim'}, { ft = "rasi" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'laravel.nvim'}, { event = "VimEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/dylan/.local/share/nvim/site/pack/packer/opt/rasi.vim/ftdetect/rasi.vim]], true)
vim.cmd [[source /home/dylan/.local/share/nvim/site/pack/packer/opt/rasi.vim/ftdetect/rasi.vim]]
time([[Sourcing ftdetect script at: /home/dylan/.local/share/nvim/site/pack/packer/opt/rasi.vim/ftdetect/rasi.vim]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
