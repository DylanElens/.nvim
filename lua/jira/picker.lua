local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local previewers = require("telescope.previewers")

local api = require("jira.api")
local config = require("jira.config")
local utils = require("jira.utils")

local M = {}

---@param issue JiraIssue
---@return string
local function make_display(issue)
	local status = issue.fields.status and issue.fields.status.name or "Unknown"
	local type_name = issue.fields.issuetype and issue.fields.issuetype.name or "?"
	return string.format("[%s] %s (%s) %s", issue.key, issue.fields.summary, type_name, status)
end

---@param issue JiraIssue
---@return table
local function entry_maker(issue)
	return {
		value = issue,
		display = make_display(issue),
		ordinal = issue.key .. " " .. issue.fields.summary,
	}
end

local function create_previewer()
	return previewers.new_buffer_previewer({
		title = "Issue Details",
		define_preview = function(self, entry)
			local issue = entry.value
			local bufnr = self.state.bufnr
			local lines = {}

			local function safe_name(obj, fallback)
				if type(obj) == "table" and obj.name then
					return obj.name
				end
				return fallback
			end
			local function safe_display(obj, fallback)
				if type(obj) == "table" and obj.displayName then
					return obj.displayName
				end
				return fallback
			end

			table.insert(lines, "# " .. issue.key .. ": " .. issue.fields.summary)
			table.insert(lines, "")
			table.insert(lines, "**Status:** " .. safe_name(issue.fields.status, "Unknown"))
			table.insert(lines, "**Type:** " .. safe_name(issue.fields.issuetype, "Unknown"))
			table.insert(lines, "**Assignee:** " .. safe_display(issue.fields.assignee, "Unassigned"))
			table.insert(lines, "**Reporter:** " .. safe_display(issue.fields.reporter, "Unknown"))
			table.insert(lines, "**Priority:** " .. safe_name(issue.fields.priority, "None"))
			table.insert(lines, "**Created:** " .. utils.format_date(issue.fields.created))
			table.insert(lines, "**Updated:** " .. utils.format_date(issue.fields.updated))
			table.insert(lines, "")
			table.insert(lines, "## Description")
			table.insert(lines, "")

			local description = utils.adf_to_text(issue.fields.description)
			if description ~= "" then
				for line in description:gmatch("[^\n]+") do
					table.insert(lines, line)
				end
			else
				table.insert(lines, "_No description_")
			end

			local checklist = utils.parse_checklist(issue.fields.customfield_10988)
			if #checklist > 0 then
				table.insert(lines, "")
				table.insert(lines, "## Acceptance Criteria")
				table.insert(lines, "")
				local checklist_lines = utils.format_checklist(checklist)
				for _, line in ipairs(checklist_lines) do
					table.insert(lines, line)
				end
			end

			vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
			vim.api.nvim_set_option_value("filetype", "markdown", { buf = bufnr })

			if #checklist == 0 then
				api.get_checklist(issue.key, function(_, checklist_str)
					if not checklist_str then
						return
					end
					if not vim.api.nvim_buf_is_valid(bufnr) then
						return
					end
					local prop_checklist = utils.parse_checklist_property(checklist_str)
					if #prop_checklist > 0 then
						local extra = { "", "## Acceptance Criteria", "" }
						for _, cl in ipairs(utils.format_checklist(prop_checklist)) do
							table.insert(extra, cl)
						end
						vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, extra)
					end
				end)
			end
		end,
	})
end

---@param prompt_bufnr number
local function action_open_browser(prompt_bufnr)
	local entry = action_state.get_selected_entry()
	if not entry then
		return
	end

	local issue = entry.value
	local cfg = config.get()
	if not cfg then
		return
	end

	local url = cfg.base_url .. "/browse/" .. issue.key
	utils.open_in_browser(url)
	actions.close(prompt_bufnr)
end

---@param prompt_bufnr number
local function action_log_time(prompt_bufnr)
	local entry = action_state.get_selected_entry()
	if not entry then
		return
	end

	local issue = entry.value
	actions.close(prompt_bufnr)

	vim.ui.input({ prompt = "Time spent (e.g. 2h, 30m): " }, function(time_spent)
		if not time_spent or time_spent == "" then
			return
		end

		vim.ui.input({ prompt = "Comment (optional): " }, function(comment)
			api.log_time(issue.key, time_spent, comment, function(err)
				if err then
					vim.notify("Failed to log time: " .. err.message, vim.log.levels.ERROR)
				else
					vim.notify("Logged " .. time_spent .. " to " .. issue.key, vim.log.levels.INFO)
				end
			end)
		end)
	end)
end

---@param prompt_bufnr number
local function action_add_comment(prompt_bufnr)
	local entry = action_state.get_selected_entry()
	if not entry then
		return
	end

	local issue = entry.value
	actions.close(prompt_bufnr)

	vim.ui.input({ prompt = "Comment: " }, function(comment)
		if not comment or comment == "" then
			return
		end

		api.add_comment(issue.key, comment, function(err)
			if err then
				vim.notify("Failed to add comment: " .. err.message, vim.log.levels.ERROR)
			else
				vim.notify("Comment added to " .. issue.key, vim.log.levels.INFO)
			end
		end)
	end)
end

---@param prompt_bufnr number
local function action_create_branch(prompt_bufnr)
	local entry = action_state.get_selected_entry()
	if not entry then
		return
	end

	local issue = entry.value
	actions.close(prompt_bufnr)

	vim.ui.select({ "feature", "service", "hotfix" }, {
		prompt = "Branch type:",
	}, function(branch_type)
		if not branch_type then
			return
		end

		local branch_name = utils.generate_branch_name(issue.key, issue.fields.summary, branch_type)

		vim.ui.input({ prompt = "Branch name: ", default = branch_name }, function(final_name)
			if not final_name or final_name == "" then
				return
			end

			vim.fn.jobstart({ "git", "checkout", "-b", final_name }, {
				on_exit = function(_, code)
					vim.schedule(function()
						if code == 0 then
							vim.notify("Created branch: " .. final_name, vim.log.levels.INFO)
						else
							vim.notify("Failed to create branch", vim.log.levels.ERROR)
						end
					end)
				end,
			})
		end)
	end)
end

---@param prompt_bufnr number
local function action_yank_key(prompt_bufnr)
	local entry = action_state.get_selected_entry()
	if not entry then
		return
	end

	local issue = entry.value
	vim.fn.setreg("+", issue.key)
	vim.notify("Yanked: " .. issue.key, vim.log.levels.INFO)
end

---@param opts? table
function M.issues(opts)
	opts = opts or {}

	local ok, err = config.validate()
	if not ok then
		vim.notify("Jira: " .. (err or "Invalid config"), vim.log.levels.ERROR)
		return
	end

	vim.notify("Loading Jira issues...", vim.log.levels.INFO)

	api.get_my_issues(function(api_err, issues)
		if api_err then
			vim.notify("Jira: " .. api_err.message, vim.log.levels.ERROR)
			return
		end

		if not issues or #issues == 0 then
			vim.notify("No issues found", vim.log.levels.INFO)
			return
		end

		pickers
			.new(opts, {
				prompt_title = "Jira Issues",
				finder = finders.new_table({
					results = issues,
					entry_maker = entry_maker,
				}),
				sorter = conf.generic_sorter(opts),
				previewer = create_previewer(),
				attach_mappings = function(prompt_bufnr, map)
					actions.select_default:replace(action_open_browser)
					map("i", "<C-t>", action_log_time)
					map("n", "<C-t>", action_log_time)
					map("i", "<C-c>", action_add_comment)
					map("n", "<C-c>", action_add_comment)
					map("i", "<C-b>", action_create_branch)
					map("n", "<C-b>", action_create_branch)
					map("i", "<C-y>", action_yank_key)
					map("n", "<C-y>", action_yank_key)
					return true
				end,
			})
			:find()
	end)
end

return M
