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
        config = function()
            local alpha = require("alpha")
            
            local coolLines = {
                [[    ███╗   ███╗ █████╗ ██╗  ██╗███████╗   ]],
                [[    ████╗ ████║██╔══██╗██║ ██╔╝██╔════╝   ]],
                [[    ██╔████╔██║███████║█████╔╝ █████╗     ]],
                [[    ██║╚██╔╝██║██╔══██║██╔═██╗ ██╔══╝     ]],
                [[    ██║ ╚═╝ ██║██║  ██║██║  ██╗███████╗   ]],
                [[    ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝   ]],
                [[      ██████╗ ██████╗  ██████╗ ██╗        ]],
                [[     ██╔════╝██╔═══██╗██╔═══██╗██║        ]],
                [[     ██║     ██║   ██║██║   ██║██║        ]],
                [[     ██║     ██║   ██║██║   ██║██║        ]],
                [[     ╚██████╗╚██████╔╝╚██████╔╝███████╗   ]],
                [[      ╚═════╝ ╚═════╝  ╚═════╝ ╚══════╝   ]],
                [[███████╗████████╗██╗   ██╗███████╗███████╗]],
                [[██╔════╝╚══██╔══╝██║   ██║██╔════╝██╔════╝]],
                [[███████╗   ██║   ██║   ██║█████╗  █████╗  ]],
                [[╚════██║   ██║   ██║   ██║██╔══╝  ██╔══╝  ]],
                [[███████║   ██║   ╚██████╔╝██║     ██║     ]],
                [[╚══════╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝     ]],
            }
            
            local robustLines = {
                [[        ██████╗ ██╗   ██╗██╗██╗     ██████╗         ]],
                [[        ██╔══██╗██║   ██║██║██║     ██╔══██╗        ]],
                [[        ██████╔╝██║   ██║██║██║     ██║  ██║        ]],
                [[        ██╔══██╗██║   ██║██║██║     ██║  ██║        ]],
                [[        ██████╔╝╚██████╔╝██║███████╗██████╔╝        ]],
                [[        ╚═════╝  ╚═════╝ ╚═╝╚══════╝╚═════╝         ]],
                [[ ██████╗  ██████╗ ██████╗ ██╗   ██╗███████╗████████╗]],
                [[ ██╔══██╗██╔═══██╗██╔══██╗██║   ██║██╔════╝╚══██╔══╝]],
                [[ ██████╔╝██║   ██║██████╔╝██║   ██║███████╗   ██║   ]],
                [[ ██╔══██╗██║   ██║██╔══██╗██║   ██║╚════██║   ██║   ]],
                [[ ██║  ██║╚██████╔╝██████╔╝╚██████╔╝███████║   ██║   ]],
                [[ ╚═╝  ╚═╝ ╚═════╝ ╚═════╝  ╚═════╝ ╚══════╝   ╚═╝   ]],
                [[     ███████╗████████╗██╗   ██╗███████╗███████╗     ]],
                [[     ██╔════╝╚══██╔══╝██║   ██║██╔════╝██╔════╝     ]],
                [[     ███████╗   ██║   ██║   ██║█████╗  █████╗       ]],
                [[     ╚════██║   ██║   ██║   ██║██╔══╝  ██╔══╝       ]],
                [[     ███████║   ██║   ╚██████╔╝██║     ██║          ]],
                [[     ╚══════╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝          ]],
            }
            
            local efficientLines = {
                [[             ██████╗██████╗  █████╗ ███████╗████████╗            ]],
                [[            ██╔════╝██╔══██╗██╔══██╗██╔════╝╚══██╔══╝            ]],
                [[            ██║     ██████╔╝███████║█████╗     ██║               ]],
                [[            ██║     ██╔══██╗██╔══██║██╔══╝     ██║               ]],
                [[            ╚██████╗██║  ██║██║  ██║██║        ██║               ]],
                [[             ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝        ╚═╝               ]],
                [[███████╗███████╗███████╗██╗ ██████╗██╗███████╗███╗   ██╗████████╗]],
                [[██╔════╝██╔════╝██╔════╝██║██╔════╝██║██╔════╝████╗  ██║╚══██╔══╝]],
                [[█████╗  █████╗  █████╗  ██║██║     ██║█████╗  ██╔██╗ ██║   ██║   ]],
                [[██╔══╝  ██╔══╝  ██╔══╝  ██║██║     ██║██╔══╝  ██║╚██╗██║   ██║   ]],
                [[███████╗██║     ██║     ██║╚██████╗██║███████╗██║ ╚████║   ██║   ]],
                [[╚══════╝╚═╝     ╚═╝     ╚═╝ ╚═════╝╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝   ]],
                [[  ███████╗██╗   ██╗███████╗████████╗███████╗███╗   ███╗███████╗  ]],
                [[  ██╔════╝╚██╗ ██╔╝██╔════╝╚══██╔══╝██╔════╝████╗ ████║██╔════╝  ]],
                [[  ███████╗ ╚████╔╝ ███████╗   ██║   █████╗  ██╔████╔██║███████╗  ]],
                [[  ╚════██║  ╚██╔╝  ╚════██║   ██║   ██╔══╝  ██║╚██╔╝██║╚════██║  ]],
                [[  ███████║   ██║   ███████║   ██║   ███████╗██║ ╚═╝ ██║███████║  ]],
                [[  ╚══════╝   ╚═╝   ╚══════╝   ╚═╝   ╚══════╝╚═╝     ╚═╝╚══════╝  ]],
            }
            
            local function lineToStartGradient(lines)
                local out = {}
                for i, line in ipairs(lines) do
                    table.insert(out, { hi = "StartLogo" .. i, line = line })
                end
                return out
            end
            
            local function lineToStartPopGradient(lines)
                local out = {}
                for i, line in ipairs(lines) do
                    local hi = "StartLogo" .. i
                    if i <= 6 then
                        hi = "StartLogo" .. i + 6
                    elseif i > 6 and i <= 12 then
                        hi = "StartLogoPop" .. i - 6
                    end
                    table.insert(out, { hi = hi, line = line })
                end
                return out
            end
            
            local function lineToStartShiftGradient(lines)
                local out = {}
                for i, line in ipairs(lines) do
                    local n = i
                    if i > 6 and i <= 12 then
                        n = i + 6
                    elseif i > 12 then
                        n = i - 6
                    end
                    table.insert(out, { hi = "StartLogo" .. n, line = line })
                end
                return out
            end
            
            local cool = lineToStartPopGradient(coolLines)
            local robust = lineToStartShiftGradient(robustLines)
            local efficient = lineToStartGradient(efficientLines)
            
            local headers = { cool, robust, efficient }
            
            local function header_chars()
                math.randomseed(os.time())
                return headers[math.random(#headers)]
            end
            
            -- Map over the headers, setting a different color for each line.
            local function header_color()
                local lines = {}
                for i, lineConfig in pairs(header_chars()) do
                    local hi = lineConfig.hi
                    local line_chars = lineConfig.line
                    local line = {
                        type = "text",
                        val = line_chars,
                        opts = {
                            hl = hi,
                            shrink_margin = false,
                            position = "center",
                        },
                    }
                    table.insert(lines, line)
                end
            
                local output = {
                    type = "group",
                    val = lines,
                    opts = { position = "center" },
                }
            
                return output
            end
            
            local theme = require("alpha.themes.theta")
            local config = theme.config
            local dashboard = require("alpha.themes.dashboard")
            local buttons = {
                type = "group",
                val = {
                    { type = "text", val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
                    { type = "padding", val = 1 },
                    dashboard.button("e", "  New file", "<cmd>ene<CR>"),
                    dashboard.button("SPC f", "  Find file"),
                    dashboard.button("SPC F", "  Find text"),
                    dashboard.button("u", "  Update plugins", "<cmd>Lazy sync<CR>"),
                    dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
                },
                position = "center",
            }
            
            config.layout[2] = header_color()
            config.layout[6] = buttons
            alpha.setup(config)
        end,
    },
    
    -- File explorer
    {
        "nvim-tree/nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFileToggle" },
        keys = {
            { "<leader>e", "<cmd>NvimTreeFindFileToggle<CR>", desc = "Toggle NvimTree" },
        },
        init = function()
            -- Create the command NvimTreeFindFileToggle to ensure it's available
            vim.api.nvim_create_user_command("NvimTreeFindFileToggle", function()
                require("nvim-tree.api").tree.toggle({find_file = true, focus = true})
            end, {})
        end,
        dependencies = {
            "kyazdani42/nvim-web-devicons",
        },
        config = function()
            -- disable netrw
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
            
            -- ensure termguicolors is enabled
            vim.opt.termguicolors = true
            
            require("nvim-tree").setup({
              sort_by = "case_sensitive",
              view = {
                width = 30,
              },
              renderer = {
                group_empty = true,
              },
              filters = {
                dotfiles = true,
              },
            })
        end,
    },
    
    -- Better UI elements
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        config = function()
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
        end,
    },
    
    {
        "akinsho/toggleterm.nvim",
        cmd = "ToggleTerm",
        keys = {
            { "<c-p>", desc = "Toggle terminal" },
            { "<leader>td", "<cmd>lua _GOBANG_TOGGLE()<CR>", desc = "Gobang terminal" },
            { "<leader>th", "<cmd>lua _HTOP_TOGGLE()<CR>", desc = "Htop terminal" },
            { "<leader>tn", "<cmd>lua _NODE_TOGGLE()<CR>", desc = "Node terminal" },
            { "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<CR>", desc = "Python terminal" },
            { "<leader>cd", "<cmd>lua _PYTHON_TOGGLE()<CR>", desc = "Python terminal" },
        },
        version = "*",
        config = function()
            local toggleterm = require("toggleterm")
            
            toggleterm.setup({
                size = 20,
                open_mapping = [[<c-p>]],
                hide_numbers = true,
                shade_filetypes = {},
                shade_terminals = true,
                shading_factor = 2,
                start_in_insert = true,
                insert_mappings = true,
                persist_size = true,
                direction = "float",
                close_on_exit = true,
                shell = vim.o.shell,
                float_opts = {
                    border = "curved",
                    winblend = 0,
                    highlights = {
                        border = "Normal",
                        background = "Normal",
                    },
                },
            })
            
            function _G.set_terminal_keymaps()
                local opts = {noremap = true}
                vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
                vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
                vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
                vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
                vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
            end
            
            vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
            
            local Terminal = require("toggleterm.terminal").Terminal
            
            -- Lazygit terminal
            local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
            function _G._LAZYGIT_TOGGLE()
                lazygit:toggle()
            end
            
            -- Node terminal
            local node = Terminal:new({ cmd = "node", hidden = true })
            function _G._NODE_TOGGLE()
                node:toggle()
            end
            
            -- NCDU terminal
            local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })
            function _G._NCDU_TOGGLE()
                ncdu:toggle()
            end
            
            -- HTOP terminal
            local htop = Terminal:new({ cmd = "htop", hidden = true })
            function _G._HTOP_TOGGLE()
                htop:toggle()
            end
            
            -- Gobang terminal
            local gobang = Terminal:new({ cmd = "gobang", hidden = true })
            function _G._GOBANG_TOGGLE()
                gobang:toggle()
            end
            
            -- Python terminal
            local python = Terminal:new({ cmd = "python", hidden = true })
            function _G._PYTHON_TOGGLE()
                python:toggle()
            end
        end,
    },
    
    -- Smart window splits
    {
        "mrjones2014/smart-splits.nvim",
        event = "VeryLazy",
        config = function()
            -- Set up keymaps for resizing splits
            vim.keymap.set('n', '<Left>', require('smart-splits').resize_left)
            vim.keymap.set('n', '<Down>', require('smart-splits').resize_down)
            vim.keymap.set('n', '<Up>', require('smart-splits').resize_up)
            vim.keymap.set('n', '<Right>', require('smart-splits').resize_right)
            
            -- If not using tmux navigation plugin, add these (commented out since you have tmux navigation)
            -- vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
            -- vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
            -- vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
            -- vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
        end,
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
    { 
        "catppuccin/nvim", 
        name = "catppuccin", 
        priority = 1000, -- Load colorscheme before other plugins
        config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- latte, frappe, macchiato, mocha
                background = { -- :h background
                    light = "latte",
                    dark = "mocha",
                },
                transparent_background = false,
                term_colors = false,
                dim_inactive = {
                    enabled = false,
                    shade = "dark",
                    percentage = 0.15,
                },
                no_italic = false, -- Force no italic
                no_bold = false, -- Force no bold
                styles = {
                    comments = { "italic" },
                    conditionals = { "italic" },
                    loops = {},
                    functions = {},
                    keywords = {},
                    strings = {},
                    variables = {},
                    numbers = {},
                    booleans = {},
                    properties = {},
                    types = {},
                    operators = {},
                },
                color_overrides = {},
                custom_highlights = {},
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    telescope = true,
                    notify = false,
                    mini = false,
                    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
                },
            })
            
            -- Setup must be called before loading
            vim.cmd.colorscheme "catppuccin"
        end,
    },
}
