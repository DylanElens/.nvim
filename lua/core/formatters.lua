-- Formatter Configuration
require("conform").setup({
	formatters_by_ft = {
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		typescriptreact = { "prettierd" },
		lua = { "stylua" },
		php = { "pint" },
		go = { "golines" },
		latex = { "latexindent" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = false,
	},
})

-- Auto commands for linting
vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
-- autocomand for compiling latex
local zahura_opened = false
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.tex",
	callback = function()
		local texfile = vim.fn.expand("%")
		local pdffile = texfile:gsub("%.tex$", ".pdf")
		local cmd = "pdflatex " .. vim.fn.shellescape(texfile)
		vim.fn.jobstart(cmd, {
			on_exit = function(_, exit_code)
				if exit_code == 0 then
					print("pdflatex compilation finished successfully.")
					-- Open the PDF file in Zathura
					if zahura_opened then
						return
					end

					local zathura_cmd = "zathura " .. vim.fn.shellescape(pdffile) .. " &"
					vim.fn.jobstart(zathura_cmd, { detach = true })
					zahura_opened = true
				else
					print("pdflatex compilation failed with exit code " .. exit_code)
				end
			end,
		})
	end,
	desc = "Asynchronously compile LaTeX and open in Zathura if successful",
})
