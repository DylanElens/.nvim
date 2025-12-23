local curl = require("plenary.curl")
local config = require("jira.config")
local utils = require("jira.utils")

local M = {}

---@param path string
---@param opts? {method?: string, body?: table, query?: table}
---@param callback fun(err: JiraError?, data: table?)
local function request(path, opts, callback)
	opts = opts or {}
	local method = opts.method or "get"

	local ok, err = config.validate()
	if not ok then
		vim.schedule(function()
			callback({ message = err or "Invalid config" }, nil)
		end)
		return
	end

	local url = config.build_url(path)
	local auth = config.get_auth_header()

	local request_opts = {
		url = url,
		headers = {
			["Authorization"] = auth,
			["Content-Type"] = "application/json",
			["Accept"] = "application/json",
		},
		callback = function(response)
			vim.schedule(function()
				if response.status >= 400 then
					local error_data = { status = response.status, message = "Request failed" }
					if response.body and response.body ~= "" then
						local ok_decode, decoded = pcall(vim.fn.json_decode, response.body)
						if ok_decode and decoded then
							error_data.message = decoded.errorMessages and decoded.errorMessages[1]
								or decoded.message
								or "Request failed"
							error_data.errors = decoded.errors
						end
					end
					callback(error_data, nil)
					return
				end

				if response.body and response.body ~= "" then
					local ok_decode, data = pcall(vim.fn.json_decode, response.body)
					if ok_decode then
						callback(nil, data)
					else
						callback({ message = "Failed to parse response" }, nil)
					end
				else
					callback(nil, {})
				end
			end)
		end,
		on_error = function(err_response)
			vim.schedule(function()
				callback({ message = err_response.message or "Request failed" }, nil)
			end)
		end,
	}

	if opts.body then
		request_opts.body = vim.fn.json_encode(opts.body)
	end

	if opts.query then
		local query_parts = {}
		for k, v in pairs(opts.query) do
			table.insert(query_parts, vim.uri_encode(k) .. "=" .. vim.uri_encode(tostring(v)))
		end
		if #query_parts > 0 then
			url = url .. "?" .. table.concat(query_parts, "&")
			request_opts.url = url
		end
	end

	curl[method](request_opts)
end

---@param jql string
---@param callback fun(err: JiraError?, issues: JiraIssue[]?)
function M.search(jql, callback)
	request("/rest/api/3/search/jql", {
		method = "get",
		query = {
			jql = jql,
			maxResults = 50,
			fields = "summary,status,assignee,reporter,issuetype,project,priority,created,updated,description,customfield_10988",
		},
	}, function(err, data)
		if err then
			callback(err, nil)
			return
		end
		---@cast data JiraSearchResponse
		callback(nil, data.issues or {})
	end)
end

---@param callback fun(err: JiraError?, issues: JiraIssue[]?)
function M.get_my_issues(callback)
	local jql = "assignee = currentUser() OR reporter = currentUser() ORDER BY updated DESC"
	M.search(jql, callback)
end

---@param project? string
---@param callback fun(err: JiraError?, issues: JiraIssue[]?)
function M.get_sprint_issues(project, callback)
	local jql = "sprint in openSprints() AND assignee = currentUser() AND status != Done"
	if project and project ~= "" then
		jql = "project = " .. project .. " AND " .. jql
	end
	jql = jql .. " ORDER BY rank ASC"
	M.search(jql, callback)
end

---@param issue_key string
---@param callback fun(err: JiraError?, issue: JiraIssue?)
function M.get_issue(issue_key, callback)
	if not utils.is_valid_issue_key(issue_key) then
		vim.schedule(function()
			callback({ message = "Invalid issue key format" }, nil)
		end)
		return
	end
	request("/rest/api/3/issue/" .. issue_key, {
		method = "get",
		query = {
			fields = "summary,status,assignee,reporter,issuetype,project,priority,created,updated,description,customfield_10988",
		},
	}, function(err, data)
		if err then
			callback(err, nil)
			return
		end
		---@cast data JiraIssue
		callback(nil, data)
	end)
end

---@param issue_key string
---@param callback fun(err: JiraError?, comments: JiraComment[]?)
function M.get_comments(issue_key, callback)
	if not utils.is_valid_issue_key(issue_key) then
		vim.schedule(function()
			callback({ message = "Invalid issue key format" }, nil)
		end)
		return
	end
	request("/rest/api/3/issue/" .. issue_key .. "/comment", {
		method = "get",
		query = { maxResults = 100 },
	}, function(err, data)
		if err then
			callback(err, nil)
			return
		end
		---@cast data JiraCommentsResponse
		callback(nil, data.comments or {})
	end)
end

---@param issue_key string
---@param body string
---@param callback fun(err: JiraError?, comment: JiraComment?)
function M.add_comment(issue_key, body, callback)
	if not utils.is_valid_issue_key(issue_key) then
		vim.schedule(function()
			callback({ message = "Invalid issue key format" }, nil)
		end)
		return
	end
	request("/rest/api/3/issue/" .. issue_key .. "/comment", {
		method = "post",
		body = {
			body = {
				type = "doc",
				version = 1,
				content = {
					{
						type = "paragraph",
						content = {
							{ type = "text", text = body },
						},
					},
				},
			},
		},
	}, function(err, data)
		if err then
			callback(err, nil)
			return
		end
		---@cast data JiraComment
		callback(nil, data)
	end)
end

---@param issue_key string
---@param callback fun(err: JiraError?, worklogs: JiraWorklog[]?)
function M.get_worklogs(issue_key, callback)
	if not utils.is_valid_issue_key(issue_key) then
		vim.schedule(function()
			callback({ message = "Invalid issue key format" }, nil)
		end)
		return
	end
	request("/rest/api/3/issue/" .. issue_key .. "/worklog", {
		method = "get",
		query = { maxResults = 100 },
	}, function(err, data)
		if err then
			callback(err, nil)
			return
		end
		---@cast data JiraWorklogsResponse
		callback(nil, data.worklogs or {})
	end)
end

---@param issue_key string
---@param time_spent string e.g. "2h", "30m", "1h 30m"
---@param comment? string
---@param callback fun(err: JiraError?, worklog: JiraWorklog?)
function M.log_time(issue_key, time_spent, comment, callback)
	if not utils.is_valid_issue_key(issue_key) then
		vim.schedule(function()
			callback({ message = "Invalid issue key format" }, nil)
		end)
		return
	end
	local body = {
		timeSpent = time_spent,
		started = os.date("!%Y-%m-%dT%H:%M:%S.000+0000"),
	}

	if comment and comment ~= "" then
		body.comment = {
			type = "doc",
			version = 1,
			content = {
				{
					type = "paragraph",
					content = {
						{ type = "text", text = comment },
					},
				},
			},
		}
	end

	request("/rest/api/3/issue/" .. issue_key .. "/worklog", {
		method = "post",
		body = body,
	}, function(err, data)
		if err then
			callback(err, nil)
			return
		end
		---@cast data JiraWorklog
		callback(nil, data)
	end)
end

---@param callback fun(err: JiraError?, user: JiraUser?)
function M.get_myself(callback)
	request("/rest/api/3/myself", { method = "get" }, function(err, data)
		if err then
			callback(err, nil)
			return
		end
		---@cast data JiraUser
		callback(nil, data)
	end)
end

---@param issue_key string
---@param callback fun(err: JiraError?, checklist: string?)
function M.get_checklist(issue_key, callback)
	if not utils.is_valid_issue_key(issue_key) then
		vim.schedule(function()
			callback({ message = "Invalid issue key format" }, nil)
		end)
		return
	end
	request("/rest/api/3/issue/" .. issue_key .. "/properties/com.railsware.SmartChecklist.checklist", {
		method = "get",
	}, function(err, data)
		if err then
			callback(nil, nil)
			return
		end
		if data and data.value then
			callback(nil, data.value)
		else
			callback(nil, nil)
		end
	end)
end

return M
