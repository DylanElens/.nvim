return {
	"nvim-neotest/neotest",
	branch = "fix/subprocess/load-adapters",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"V13Axel/neotest-pest",
	},
	config = function()
		local neotest = require("neotest")
		neotest.setup({
			adapters = {
				require("neotest-pest")({
					ignore_dirs = { "vendor", "node_modules" },
					test_file_suffixes = { "Test.php", "_test.php", "PestTest.php" },
					compact = true,
				}),
			},
		})

		vim.keymap.set("n", "<leader>tr", neotest.run.run, { desc = "Run nearest test" })
		vim.keymap.set("n", "<leader>tf", function()
			neotest.run.run(vim.fn.expand("%"))
		end, { desc = "Run current file tests" })
		vim.keymap.set("n", "<leader>ta", neotest.run.run_last, { desc = "Run last test" })
		vim.keymap.set("n", "<leader>tA", function()
			neotest.run.run({ suite = true })
		end, { desc = "Run all tests" })
		vim.keymap.set("n", "<leader>ts", neotest.summary.toggle, { desc = "Toggle test summary" })
		vim.keymap.set("n", "<leader>to", neotest.output.open, { desc = "Open test output" })
		vim.keymap.set("n", "<leader>tO", function()
			neotest.output.open({ enter = true })
		end, { desc = "Open test output and enter" })
		vim.keymap.set("n", "<leader>tp", neotest.output_panel.toggle, { desc = "Toggle output panel" })
		vim.keymap.set("n", "<leader>td", function()
			neotest.run.run({ strategy = "dap" })
		end, { desc = "Debug nearest test" })
		vim.keymap.set("n", "]t", function()
			neotest.jump.next({ status = "failed" })
		end, { desc = "Jump to next failed test" })
		vim.keymap.set("n", "[t", function()
			neotest.jump.prev({ status = "failed" })
		end, { desc = "Jump to previous failed test" })
	end,
}
