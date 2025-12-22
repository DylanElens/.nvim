local M = {}

---@param branch string
---@return string?
function M.extract_ticket_from_branch(branch)
	local pattern = "([A-Z][A-Z0-9]+-[0-9]+)"
	return branch:match(pattern)
end

---@return string?
function M.get_current_branch()
	local result = vim.fn.system("git branch --show-current")
	if vim.v.shell_error ~= 0 then
		return nil
	end
	local branch = vim.trim(result)
	if branch ~= "" then
		return branch
	end
	return nil
end

---@return string?
function M.get_current_ticket()
	local branch = M.get_current_branch()
	if not branch then
		return nil
	end
	return M.extract_ticket_from_branch(branch)
end

---@param text string
---@return string
function M.to_kebab_case(text)
	local result = text:lower()
	result = result:gsub("[^%w%s-]", "")
	result = result:gsub("%s+", "-")
	result = result:gsub("%-+", "-")
	result = result:gsub("^%-", "")
	result = result:gsub("%-$", "")
	if #result > 50 then
		result = result:sub(1, 50):gsub("%-$", "")
	end
	return result
end

---@param ticket_key string
---@param summary string
---@param branch_type "feature"|"service"|"hotfix"
---@return string
function M.generate_branch_name(ticket_key, summary, branch_type)
	local kebab = M.to_kebab_case(summary)
	return branch_type .. "/" .. ticket_key .. "-" .. kebab
end

---@param adf JiraAdf?
---@return string
function M.adf_to_text(adf)
	if not adf or not adf.content then
		return ""
	end

	local lines = {}

	local function extract_text(content)
		for _, node in ipairs(content) do
			if node.type == "text" and node.text then
				table.insert(lines, node.text)
			elseif node.type == "paragraph" and node.content then
				extract_text(node.content)
				table.insert(lines, "")
			elseif node.type == "hardBreak" then
				table.insert(lines, "")
			elseif node.content then
				extract_text(node.content)
			end
		end
	end

	extract_text(adf.content)
	return table.concat(lines, "\n"):gsub("\n\n\n+", "\n\n")
end

---@param iso_date string
---@return string
function M.format_date(iso_date)
	local year, month, day, hour, min = iso_date:match("(%d+)-(%d+)-(%d+)T(%d+):(%d+)")
	if year then
		return string.format("%s-%s-%s %s:%s", year, month, day, hour, min)
	end
	return iso_date
end

---@param seconds number
---@return string
function M.format_time_spent(seconds)
	local hours = math.floor(seconds / 3600)
	local minutes = math.floor((seconds % 3600) / 60)
	if hours > 0 and minutes > 0 then
		return string.format("%dh %dm", hours, minutes)
	elseif hours > 0 then
		return string.format("%dh", hours)
	else
		return string.format("%dm", minutes)
	end
end

---@param url string
function M.open_in_browser(url)
	if not url:match("^https?://[%w%-%.]+") then
		vim.notify("Invalid URL", vim.log.levels.ERROR)
		return
	end

	local cmd
	if vim.fn.has("mac") == 1 then
		cmd = { "open", url }
	elseif vim.fn.has("unix") == 1 then
		cmd = { "xdg-open", url }
	elseif vim.fn.has("win32") == 1 then
		cmd = { "cmd", "/c", "start", url }
	end

	if cmd then
		vim.fn.jobstart(cmd, { detach = true })
	end
end

---@param key string
---@return boolean
function M.is_valid_issue_key(key)
	return key ~= nil and key:match("^[A-Z][A-Z0-9]*%-[0-9]+$") ~= nil
end

---@class ChecklistItem
---@field status "done"|"todo"|"skipped"|"in_progress"
---@field text string

---@param checklist_field table?
---@return ChecklistItem[]
function M.parse_checklist(checklist_field)
	local items = {}
	if type(checklist_field) ~= "table" or not checklist_field.v then
		return items
	end

	for line in checklist_field.v:gmatch("[^\n]+") do
		local prefix = line:sub(1, 1)
		local text = line:sub(3)

		local status = "todo"
		if prefix == "+" then
			status = "done"
		elseif prefix == "-" then
			status = "todo"
		elseif prefix == "x" then
			status = "skipped"
		elseif prefix == "~" then
			status = "in_progress"
		end

		if text and text ~= "" then
			table.insert(items, { status = status, text = text })
		end
	end

	return items
end

---@param checklist_str string?
---@return ChecklistItem[]
function M.parse_checklist_property(checklist_str)
	local items = {}
	if type(checklist_str) ~= "string" or checklist_str == "" then
		return items
	end

	for line in checklist_str:gmatch("[^\n]+") do
		local prefix = line:sub(1, 1)
		local text = line:sub(3)

		local status = "todo"
		if prefix == "+" then
			status = "done"
		elseif prefix == "-" then
			status = "todo"
		elseif prefix == "x" then
			status = "skipped"
		elseif prefix == "~" then
			status = "in_progress"
		end

		if text and text ~= "" then
			table.insert(items, { status = status, text = text })
		end
	end

	return items
end

---@param items ChecklistItem[]
---@return string[]
function M.format_checklist(items)
	local lines = {}
	local icons = {
		done = "✓",
		todo = "○",
		skipped = "✗",
		in_progress = "◐",
	}

	for _, item in ipairs(items) do
		local icon = icons[item.status] or "○"
		table.insert(lines, icon .. " " .. item.text)
	end

	return lines
end

return M
