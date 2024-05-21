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
	fg = "#abb2bf",
	bg = "#1e222a",
	alt_fg = "#8b92a8",
	alt_bg = "#1b1f27",
	line = "#282C34",
	dark_gray = "#3e4451",
	gray = "#545862",
	context = "#ffffff",
	light_gray = "#c8ccd4",
	red = "#d05c65",
	blue = "#519fdf",
	green = "#7da869",
	cyan = "#46a6b2",
	orange = "#c18a56",
	yellow = "#d5b06b",
	purple = "#b668cd",
	magenta = "#D16D9E",
	cursor_fg = "#415062",
	cursor_bg = "#AbAbAf",
	sign_add = "#587c0c",
	sign_change = "#0c7d9d",
	sign_delete = "#94151b",
	sign_add_alt = "#73C991",
	sign_change_alt = "#CCA700",
	error = "#db4b4b",
	warn = "#eeaf58",
	info = "#1cbc9b",
	hint = "#4bc1fe",
	error_bg = "#31262d",
	warn_bg = "#32302f",
	info_bg = "#1e3135",
	hint_bg = "#22323f",
	reference = "#2e303b",
	success_green = "#14C50B",
	folder_blue = "#42A5F5",
	ui_blue = "#1e4870",
	ui2_blue = "#042E48",
	ui3_blue = "#0195F7",
	ui4_blue = "#75BEFF",
	ui5_blue = "#083C5A",
	ui_orange = "#E8AB53",
	ui2_orange = "#613214",
	ui_purple = "#B180D7",
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
