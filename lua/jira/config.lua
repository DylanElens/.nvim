local M = {}

---@type JiraConfig?
local config = nil

---@return JiraConfig?, string?
function M.get()
	if config then
		return config, nil
	end

	local base_url = os.getenv("JIRA_URL")
	local email = os.getenv("JIRA_EMAIL")
	local token = os.getenv("JIRA_TOKEN")

	if not base_url then
		return nil, "JIRA_URL environment variable not set"
	end
	if not email then
		return nil, "JIRA_EMAIL environment variable not set"
	end
	if not token then
		return nil, "JIRA_TOKEN environment variable not set"
	end

	base_url = base_url:gsub("/$", "")

	config = {
		base_url = base_url,
		email = email,
		token = token,
	}

	return config, nil
end

---@return string
function M.get_auth_header()
	local cfg, err = M.get()
	if not cfg then
		error(err)
	end
	local credentials = cfg.email .. ":" .. cfg.token
	return "Basic " .. vim.base64.encode(credentials)
end

---@param path string
---@return string
function M.build_url(path)
	local cfg, err = M.get()
	if not cfg then
		error(err)
	end
	return cfg.base_url .. path
end

---@return boolean, string?
function M.validate()
	local cfg, err = M.get()
	if not cfg then
		return false, err
	end
	return true, nil
end

return M
