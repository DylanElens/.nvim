local M = {}

local preview_group = vim.api.nvim_create_augroup("quickfix-live-preview", { clear = true })
local preview_ns = vim.api.nvim_create_namespace("quickfix-live-preview")
local preview_highlight = "QuickfixPreviewLine"

local function get_current_entry()
	local items = vim.fn.getqflist()
	local idx = vim.fn.line(".")
	return items[idx]
end

local function clear_preview_highlight()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_valid(buf) then
			vim.api.nvim_buf_clear_namespace(buf, preview_ns, 0, -1)
		end
	end
end

local function set_preview_highlight()
	vim.api.nvim_set_hl(0, preview_highlight, {
		bg = "#3c3836",
		fg = "NONE",
	})
end

local function get_target_win()
	local quickfix_win = vim.api.nvim_get_current_win()
	local wins = vim.api.nvim_tabpage_list_wins(0)

	for _, win in ipairs(wins) do
		if win ~= quickfix_win then
			local config = vim.api.nvim_win_get_config(win)
			if config.relative == "" then
				local buf = vim.api.nvim_win_get_buf(win)
				if vim.bo[buf].buftype == "" then
					return win
				end
			end
		end
	end
end

function M.preview_current_entry()
	if vim.bo.buftype ~= "quickfix" then
		return
	end

	local item = get_current_entry()
	if not item or item.bufnr == 0 then
		return
	end

	local target_win = get_target_win()
	if not target_win or not vim.api.nvim_win_is_valid(target_win) then
		return
	end

	local current_win = vim.api.nvim_get_current_win()
	vim.api.nvim_win_call(target_win, function()
		vim.cmd(("silent keepjumps buffer %d"):format(item.bufnr))

			if item.lnum and item.lnum > 0 then
				clear_preview_highlight()
				vim.api.nvim_buf_add_highlight(item.bufnr, preview_ns, preview_highlight, item.lnum - 1, 0, -1)
				local col = item.col and item.col > 0 and item.col - 1 or 0
				pcall(vim.api.nvim_win_set_cursor, target_win, { item.lnum, col })
			end

		vim.cmd("normal! zz")
	end)
	vim.api.nvim_set_current_win(current_win)
end

function M.setup()
	set_preview_highlight()

	vim.api.nvim_create_autocmd("ColorScheme", {
		group = preview_group,
		pattern = "*",
		callback = set_preview_highlight,
	})

	vim.api.nvim_create_autocmd("FileType", {
		group = preview_group,
		pattern = "qf",
		callback = function(event)
			local opts = { buffer = event.buf, silent = true }
			vim.keymap.set("n", "j", function()
				vim.cmd("normal! j")
				M.preview_current_entry()
			end, opts)
			vim.keymap.set("n", "k", function()
				vim.cmd("normal! k")
				M.preview_current_entry()
			end, opts)
			vim.keymap.set("n", "<Down>", function()
				vim.cmd("normal! j")
				M.preview_current_entry()
			end, opts)
			vim.keymap.set("n", "<Up>", function()
				vim.cmd("normal! k")
				M.preview_current_entry()
			end, opts)
				vim.keymap.set("n", "<CR>", function()
					local item = get_current_entry()
					if not item then
						return
					end
					clear_preview_highlight()
					vim.cmd(("cc %d"):format(vim.fn.line(".")))
				end, opts)
			vim.schedule(M.preview_current_entry)
		end,
	})

	vim.api.nvim_create_autocmd("CursorMoved", {
		group = preview_group,
		pattern = "*",
		callback = function()
			if vim.bo.buftype == "quickfix" then
				M.preview_current_entry()
			end
		end,
	})
end

return M
