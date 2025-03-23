# Neovim Configuration

A modular Neovim configuration using Lazy package manager.

## Structure

- `init.lua`: Main entry point that loads all required modules
- `lua/core/`: Core configuration files
  - `plugins.lua`: Lazy.nvim bootstrap and plugin management
  - `options.lua`: Vim options
  - `keys.lua`: Keymaps
  - `lsp.lua`: LSP configuration
  - etc.
- `lua/plugins/`: Individual plugin specifications
  - `core.lua`: Core dependencies
  - `lsp.lua`: LSP-related plugins
  - `completion.lua`: Completion-related plugins
  - `treesitter.lua`: Treesitter configuration
  - `telescope.lua`: Telescope fuzzy finder
  - `git.lua`: Git integration plugins
  - `ui.lua`: UI enhancement plugins
  - `coding.lua`: Coding tools and utilities
  - `misc.lua`: Miscellaneous plugins

## Plugin Organization

Plugins are organized in a modular way using Lazy.nvim's `import` feature:

1. The main `lua/core/plugins.lua` bootstraps Lazy.nvim and loads all plugins
2. Individual plugin specifications are in separate files in the `lua/plugins/` directory
3. Each plugin file returns a table of plugin specs

## Adding New Plugins

To add a new plugin:

1. Decide which category it belongs to
2. Add it to the appropriate file in `lua/plugins/`
3. Or create a new file for it if it's a new category

Example:

```lua
-- In lua/plugins/mynewplugin.lua
return {
    {
        "username/plugin-name",
        config = function()
            require("plugin-name").setup({
                -- your config here
            })
        end,
    },
}
```
