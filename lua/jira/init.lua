local api = require("jira.api")
local config = require("jira.config")
local utils = require("jira.utils")
local picker = require("jira.picker")

local M = {}

M.api = api
M.config = config
M.utils = utils
M.picker = picker

function M.setup()
	vim.api.nvim_create_user_command("Jira", function()
		picker.issues()
	end, { desc = "Open Jira picker" })

	vim.api.nvim_create_user_command("JiraLog", function(opts)
		local args = vim.split(opts.args, "%s+")

		local ticket_key
		local time_spent

		if #args == 1 then
			ticket_key = utils.get_current_ticket()
			time_spent = args[1]
		elseif #args >= 2 then
			if args[1]:match("^[A-Z]+-[0-9]+$") then
				ticket_key = args[1]
				time_spent = args[2]
			else
				ticket_key = utils.get_current_ticket()
				time_spent = args[1]
			end
		else
			vim.notify("Usage: :JiraLog [TICKET-123] <time>", vim.log.levels.ERROR)
			return
		end

		if not ticket_key then
			vim.notify("Could not determine ticket. Provide ticket key or use from a feature branch.", vim.log.levels.ERROR)
			return
		end

		if not time_spent or time_spent == "" then
			vim.notify("Usage: :JiraLog [TICKET-123] <time>", vim.log.levels.ERROR)
			return
		end

		vim.notify("Logging " .. time_spent .. " to " .. ticket_key .. "...", vim.log.levels.INFO)

		api.log_time(ticket_key, time_spent, nil, function(err)
			if err then
				vim.notify("Failed to log time: " .. err.message, vim.log.levels.ERROR)
			else
				vim.notify("Logged " .. time_spent .. " to " .. ticket_key, vim.log.levels.INFO)
			end
		end)
	end, {
		nargs = "+",
		desc = "Log time to Jira ticket",
		complete = function()
			local ticket = utils.get_current_ticket()
			if ticket then
				return { ticket }
			end
			return {}
		end,
	})

	vim.api.nvim_create_user_command("JiraComment", function(opts)
		local args = vim.split(opts.args, "%s+", { trimempty = true })

		local ticket_key
		local comment_start_idx = 1

		if #args > 0 and args[1]:match("^[A-Z]+-[0-9]+$") then
			ticket_key = args[1]
			comment_start_idx = 2
		else
			ticket_key = utils.get_current_ticket()
		end

		if not ticket_key then
			vim.notify("Could not determine ticket. Provide ticket key or use from a feature branch.", vim.log.levels.ERROR)
			return
		end

		local comment = table.concat(args, " ", comment_start_idx)
		if comment == "" then
			vim.ui.input({ prompt = "Comment for " .. ticket_key .. ": " }, function(input)
				if input and input ~= "" then
					api.add_comment(ticket_key, input, function(err)
						if err then
							vim.notify("Failed to add comment: " .. err.message, vim.log.levels.ERROR)
						else
							vim.notify("Comment added to " .. ticket_key, vim.log.levels.INFO)
						end
					end)
				end
			end)
			return
		end

		api.add_comment(ticket_key, comment, function(err)
			if err then
				vim.notify("Failed to add comment: " .. err.message, vim.log.levels.ERROR)
			else
				vim.notify("Comment added to " .. ticket_key, vim.log.levels.INFO)
			end
		end)
	end, {
		nargs = "*",
		desc = "Add comment to Jira ticket",
	})

	vim.api.nvim_create_user_command("JiraOpen", function(opts)
		local ticket_key = opts.args

		if ticket_key == "" then
			ticket_key = utils.get_current_ticket()
		end

		if not ticket_key then
			vim.notify("Could not determine ticket", vim.log.levels.ERROR)
			return
		end

		local cfg = config.get()
		if not cfg then
			vim.notify("Jira not configured", vim.log.levels.ERROR)
			return
		end

		local url = cfg.base_url .. "/browse/" .. ticket_key
		utils.open_in_browser(url)
	end, {
		nargs = "?",
		desc = "Open Jira ticket in browser",
	})

	vim.api.nvim_create_user_command("JiraTest", function()
		local ok, err = config.validate()
		if not ok then
			vim.notify("Config error: " .. (err or "Unknown"), vim.log.levels.ERROR)
			return
		end

		vim.notify("Testing Jira connection...", vim.log.levels.INFO)

		api.get_myself(function(api_err, user)
			if api_err then
				vim.notify("Connection failed: " .. api_err.message, vim.log.levels.ERROR)
			elseif user and user.displayName then
				vim.notify("Connected as: " .. user.displayName, vim.log.levels.INFO)
			else
				vim.notify("Connected successfully", vim.log.levels.INFO)
			end
		end)
	end, { desc = "Test Jira connection" })
end

return M
