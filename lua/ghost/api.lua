local context = require("ghost.context")

---@class GhostApi
local M = {}

---@type string|nil
M.api_key = os.getenv("ANTHROPIC_API_KEY")
---@type string
M.model = "claude-haiku-4-5-20251001"
---@type string
M.url = "https://api.anthropic.com/v1/messages"
---@type integer
M.max_tokens = 256
---@type integer|nil
M.current_job = nil
---@type integer
M.request_id = 0

M.tools = {
	{
		name = "suggest",
		description = "Insert a code completion at the cursor position",
		input_schema = {
			type = "object",
			properties = {
				code = {
					type = "string",
					description = "The exact code to insert at the cursor. No markdown, no backticks, no explanation.",
				},
			},
			required = { "code" },
		},
	},
}

M.system = [[You are an inline code completion engine running inside neovim.
You will receive the current file with a <CURSOR> marker where the user is typing.
You MUST call the suggest tool with the code to insert at <CURSOR>.
Rules:
- Do not repeat code that already exists before or after <CURSOR>
- Keep completions short and relevant (1-3 lines typical)
- Match the existing code style, indentation, and naming conventions
- If there is nothing useful to suggest, call suggest with an empty string]]

---@return nil
function M.cancel()
	if M.current_job then
		vim.fn.jobstop(M.current_job)
		M.current_job = nil
	end
end

---@param prefix string
---@param suffix string
---@param filename string
---@param callback fun(text: string): nil
---@return nil
function M.complete(prefix, suffix, filename, callback)
	M.cancel()

	M.request_id = M.request_id + 1
	local this_request = M.request_id

	local session_context = context.format()
	local context_block = session_context ~= "" and ("\n\n" .. session_context .. "\n") or ""

	local prompt = string.format(
		"%sFile: %s\n\n%s<CURSOR>%s",
		context_block,
		filename,
		prefix,
		suffix
	)

	local body = vim.fn.json_encode({
		model = M.model,
		max_tokens = M.max_tokens,
		system = M.system,
		tools = M.tools,
		tool_choice = { type = "tool", name = "suggest" },
		messages = {
			{ role = "user", content = prompt },
		},
	})

	local stdout_chunks = {}
	local stderr_chunks = {}

	M.current_job = vim.fn.jobstart({
		"curl",
		"--silent",
		"--no-buffer",
		"-X", "POST",
		M.url,
		"-H", "Content-Type: application/json",
		"-H", "x-api-key: " .. M.api_key,
		"-H", "anthropic-version: 2023-06-01",
		"-d", body,
	}, {
		stdout_buffered = true,
		stderr_buffered = true,
		on_stdout = function(_, data)
			if data then
				for _, line in ipairs(data) do
					table.insert(stdout_chunks, line)
				end
			end
		end,
		on_stderr = function(_, data)
			if data then
				for _, line in ipairs(data) do
					table.insert(stderr_chunks, line)
				end
			end
		end,
		on_exit = function(_, exit_code)
			vim.schedule(function()
				M.current_job = nil

				if this_request ~= M.request_id then
					return
				end

				if exit_code ~= 0 then
					vim.notify("[ghost] curl failed: " .. table.concat(stderr_chunks, "\n"), vim.log.levels.ERROR)
					return
				end

				local raw = table.concat(stdout_chunks, "\n")
				local ok, decoded = pcall(vim.fn.json_decode, raw)
				if not ok or not decoded then
					vim.notify("[ghost] failed to parse response", vim.log.levels.ERROR)
					return
				end

				if decoded.error then
					vim.notify("[ghost] API error: " .. (decoded.error.message or "unknown"), vim.log.levels.ERROR)
					return
				end

				local code = M.parse_tool_call(decoded)
				if code and code ~= "" then
					callback(code)
				end
			end)
		end,
	})
end

---@param response table
---@return string|nil
function M.parse_tool_call(response)
	if not response.content then
		return nil
	end
	for _, block in ipairs(response.content) do
		if block.type == "tool_use" and block.name == "suggest" then
			return block.input and block.input.code or nil
		end
	end
	return nil
end

return M
