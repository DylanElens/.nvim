local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Import all plugins from the plugins directory
    { import = "plugins" },
}, {
    -- Lazy options here
    ui = {
        border = "rounded",
    },
    change_detection = {
        enabled = true,
        notify = false,
    },
})
