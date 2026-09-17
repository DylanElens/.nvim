local api = require("ghost.api")
local context = require("ghost.context")

---@class GhostModule
local M = {}

local ns = vim.api.nvim_create_namespace("ghost")

local timer = vim.loop.new_timer()
local debounce_ms = 500

---@return string prefix, string suffix, string filename
function M.get_context()
	local buf = vim.api.nvim_get_current_buf()
	local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
	local cursor = vim.api.nvim_win_get_cursor(0)
	local row, col = cursor[1], cursor[2]

	local prefix_lines = {}

	for i = 1, row - 1 do
		table.insert(prefix_lines, lines[i])
	end

	table.insert(prefix_lines, string.sub(lines[row] or "", 1, col))

	local suffix_lines = {}
	table.insert(suffix_lines, string.sub(lines[row] or "", col + 1))
	for i = row + 1, #lines do
		table.insert(suffix_lines, lines[i])
	end

	local prefix = table.concat(prefix_lines, "\n")
	local suffix = table.concat(suffix_lines, "\n")
	local filename = vim.api.nvim_buf_get_name(buf)

	return prefix, suffix, filename
end

---@return nil
function M.request_completion()
	local prefix, suffix, filename = M.get_context()
	api.complete(prefix, suffix, filename, function(text)
		M.show_ghost_text(text)
	end)
end

---@param text string
---@return nil
function M.show_ghost_text(text)
	local buf = vim.api.nvim_get_current_buf()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local row, col = cursor[1], cursor[2]

	vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)

	local suggestion_lines = vim.split(text, "\n", { plain = true })
	if #suggestion_lines == 0 then
		return
	end

	local first_line = suggestion_lines[1]
	local virt_lines = {}
	for i = 2, #suggestion_lines do
		table.insert(virt_lines, { { suggestion_lines[i], "GhostText" } })
	end

	vim.api.nvim_buf_set_extmark(buf, ns, row - 1, col, {
		virt_text = { { first_line, "GhostText" } },
		virt_text_pos = "overlay",
		virt_lines = #virt_lines > 0 and virt_lines or nil,
	})

	M.pending_suggestion = {
		text = text,
		row = row,
		col = col,
	}
end

---@return boolean
function M.accept()
	if not M.pending_suggestion then
		return false
	end

	local buf = vim.api.nvim_get_current_buf()
	local s = M.pending_suggestion
	local suggestion_lines = vim.split(s.text, "\n", { plain = true })

	vim.api.nvim_buf_set_text(buf, s.row - 1, s.col, s.row - 1, s.col, suggestion_lines)
	vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)

	local last_line_idx = s.row - 1 + #suggestion_lines - 1
	local last_line_col = #suggestion_lines > 1 and #suggestion_lines[#suggestion_lines] or s.col + #suggestion_lines[1]
	vim.api.nvim_win_set_cursor(0, { last_line_idx + 1, last_line_col })

	context.add(vim.api.nvim_buf_get_name(buf), s.row, s.text)

	M.pending_suggestion = nil
	return true
end

---@return nil
function M.schedule_completion()
	if not timer then
		return
	end
	timer:stop()
	timer:start(
		debounce_ms,
		0,
		vim.schedule_wrap(function()
			M.request_completion()
		end)
	)
end

---@param opts? table
---@return nil
function M.setup(opts)
	vim.api.nvim_set_hl(0, "GhostText", { fg = "#6c7086", italic = true })

	context.start_diff_polling()

	vim.keymap.set("i", "<Tab>", function()
		if not M.accept() then
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
		end
	end, { noremap = true })

	vim.api.nvim_create_autocmd({ "TextChangedI", "CursorMovedI" }, {
		callback = function()
			vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
			M.pending_suggestion = nil
			M.schedule_completion()
		end,
	})

	vim.api.nvim_create_autocmd("InsertLeave", {
		callback = function()
			if timer then
				timer:stop()
			end
			vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
			M.pending_suggestion = nil
		end,
	})
end

return M
