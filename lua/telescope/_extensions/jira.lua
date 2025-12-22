local picker = require("jira.picker")

return require("telescope").register_extension({
	setup = function() end,
	exports = {
		jira = picker.issues,
	},
})
