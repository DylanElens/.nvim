-- Linter Configuration
local jsFiles = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
local jsLinter = { "eslint_d" }
local ft_configs = {}

local phpFiles = { "php" }
local phpLinter = { "phpstan" }

for _, value in pairs(jsFiles) do
	ft_configs[value] = jsLinter
end

for _, value in pairs(phpFiles) do
	ft_configs[value] = phpLinter
end

require("lint").linters_by_ft = ft_configs
