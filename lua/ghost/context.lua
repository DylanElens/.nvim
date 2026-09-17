---@class GhostContextEntry
---@field filename string
---@field line integer
---@field text string

---@class GhostContext
local M = {}

---@type GhostContextEntry[]
M.history = {}
---@type integer
M.max_entries = 50
---@type string
M.diff_cache = ""
---@type integer
M.diff_interval_ms = 10000

---@param filename string
---@param line integer
---@param text string
---@return nil
function M.add(filename, line, text)
	table.insert(M.history, {
		filename = filename,
		line = line,
		text = text,
	})
	if #M.history > M.max_entries then
		table.remove(M.history, 1)
	end
end

---@param callback fun(diff: string): nil
---@return nil
function M.fetch_diff(callback)
	local chunks = {}
	vim.fn.jobstart({ "git", "diff", "--no-color" }, {
		stdout_buffered = true,
		on_stdout = function(_, data)
			if data then
				for _, line in ipairs(data) do
					table.insert(chunks, line)
				end
			end
		end,
		on_exit = function()
			vim.schedule(function()
				local diff = table.concat(chunks, "\n")
				M.diff_cache = diff
				if callback then
					callback(diff)
				end
			end)
		end,
	})
end

---@return nil
function M.start_diff_polling()
	local timer = vim.loop.new_timer()
	if not timer then
		return
	end
	M.fetch_diff(function() end)
	timer:start(M.diff_interval_ms, M.diff_interval_ms, vim.schedule_wrap(function()
		M.fetch_diff(function() end)
	end))
end

---@return string
function M.format()
	local parts = {}

	if M.diff_cache ~= "" then
		table.insert(parts, "Current git diff (files changed):\n" .. M.diff_cache)
	end

	if #M.history > 0 then
		table.insert(parts, "Recently accepted completions this session:")
		for _, entry in ipairs(M.history) do
			table.insert(parts, string.format("  %s:%d -> %s", entry.filename, entry.line, entry.text))
		end
	end

	return table.concat(parts, "\n\n")
end

---@return nil
function M.clear()
	M.history = {}
	M.diff_cache = ""
end

return M
