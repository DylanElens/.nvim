local status_ok, navic = pcall(require, "nvim-navic")
if not status_ok then
	return
end

local icons = require("core.icons")

navic.setup({
	icons = {
		File = " ",
		Module = " ",
		Namespace = " ",
		Package = " ",
		Class = " ",
		Method = " ",
		Property = " ",
		Field = " ",
		Constructor = " ",
		Enum = " ",
		Interface = " ",
		Function = " ",
		Variable = " ",
		Constant = " ",
		String = " ",
		Number = " ",
		Boolean = " ",
		Array = " ",
		Object = " ",
		Key = " ",
		Null = " ",
		EnumMember = " ",
		Struct = " ",
		Event = " ",
		Operator = " ",
		TypeParameter = " ",
	},
	highlight = true,
	separator = " " .. icons.ui.ChevronRight .. " ",
	depth_limit = 0,
	depth_limit_indicator = "..",
})

local c = {
	fg = "#ebdbb2",
	bg = "#282828",
	alt_fg = "#d5c4a1",
	alt_bg = "#3c3836",
	line = "#3c3836",
	dark_gray = "#504945",
	gray = "#665c54",
	context = "#ebdbb2",
	light_gray = "#fbf1c7",
	red = "#fb4934",
	blue = "#83a598",
	green = "#b8bb26",
	cyan = "#8ec07c",
	orange = "#fe8019",
	yellow = "#fabd2f",
	purple = "#d3869b",
	magenta = "#d3869b",
	cursor_fg = "#282828",
	cursor_bg = "#ebdbb2",
	sign_add = "#98971a",
	sign_change = "#458588",
	sign_delete = "#cc241d",
	sign_add_alt = "#b8bb26",
	sign_change_alt = "#83a598",
	error = "#fb4934",
	warn = "#fabd2f",
	info = "#83a598",
	hint = "#8ec07c",
	error_bg = "#3c3836",
	warn_bg = "#3c3836",
	info_bg = "#3c3836",
	hint_bg = "#3c3836",
	reference = "#504945",
	success_green = "#b8bb26",
	folder_blue = "#83a598",
	ui_blue = "#458588",
	ui2_blue = "#3c3836",
	ui3_blue = "#83a598",
	ui4_blue = "#bdae93",
	ui5_blue = "#504945",
	ui_orange = "#fe8019",
	ui2_orange = "#504945",
	ui_purple = "#d3869b",
	gruvbox_red = "#fb4934",
}

local hl = vim.api.nvim_set_hl
-- Navic
hl(0, "NavicIconsFile", { fg = c.fg, bg = "NONE" })
hl(0, "NavicIconsModule", { fg = c.cyan, bg = "NONE" })
hl(0, "NavicIconsNamespace", { fg = c.fg, bg = "NONE" })
hl(0, "NavicIconsPackage", { fg = c.fg, bg = "NONE" })
hl(0, "NavicIconsClass", { fg = c.cyan, bg = "NONE" })
hl(0, "NavicIconsMethod", { fg = c.blue, bg = "NONE" })
hl(0, "NavicIconsProperty", { fg = c.red, bg = "NONE" })
hl(0, "NavicIconsField", { fg = c.red, bg = "NONE" })
hl(0, "NavicIconsConstructor", { fg = c.cyan, bg = "NONE" })
hl(0, "NavicIconsEnum", { fg = c.cyan, bg = "NONE" })
hl(0, "NavicIconsInterface", { fg = c.cyan, bg = "NONE" })
hl(0, "NavicIconsFunction", { fg = c.blue, bg = "NONE" })
hl(0, "NavicIconsVariable", { fg = c.red, bg = "NONE" })
hl(0, "NavicIconsConstant", { fg = c.orange, bg = "NONE" })
hl(0, "NavicIconsString", { fg = c.green, bg = "NONE" })
hl(0, "NavicIconsNumber", { fg = c.orange, bg = "NONE" })
hl(0, "NavicIconsBoolean", { fg = c.orange, bg = "NONE" })
hl(0, "NavicIconsArray", { fg = c.cyan, bg = "NONE" })
hl(0, "NavicIconsObject", { fg = c.cyan, bg = "NONE" })
hl(0, "NavicIconsKey", { fg = c.purple, bg = "NONE" })
hl(0, "NavicIconsKeyword", { fg = c.purple, bg = "NONE" })
hl(0, "NavicIconsNull", { fg = c.orange, bg = "NONE" })
hl(0, "NavicIconsEnumMember", { fg = c.orange, bg = "NONE" })
hl(0, "NavicIconsStruct", { fg = c.cyan, bg = "NONE" })
hl(0, "NavicIconsEvent", { fg = c.yellow, bg = "NONE" })
hl(0, "NavicIconsOperator", { fg = c.fg, bg = "NONE" })
hl(0, "NavicIconsTypeParameter", { fg = c.red, bg = "NONE" })
hl(0, "NavicText", { fg = c.context, bg = "NONE" })
hl(0, "NavicSeparator", { fg = c.context, bg = "NONE" })
-- hl(0, "@tag", { fg = c.gruvbox_red, bg = "NONE" })
