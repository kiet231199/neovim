local editor   = require("plugin.ui.menu.editor")
local lsp      = require("plugin.ui.menu.lsp")
local terminal = require("plugin.ui.menu.terminal")

return {
	{
		name = "Open Explorer",
		cmd = "Neotree toggle reveal",
		rtxt = "F5",
	},

	{
		name = "Open Buffer list",
		cmd = "JABSOpen",
		rtxt = "Tab",
	},

	{
		name = "Open Outline",
		cmd = "Lsp saga",
		rtxt = "F6",
	},

	{ name = "separator" },

	{
		name = "  Lsp Actions",
		hl = "Exblue",
		items = lsp.normal,
	},

	{ name = "separator" },

	{
		name = "Load Session"
	},

	{
		name = "Save Session"
	},

	{
		name = "Delete Session"
	},

	{ name = "separator" },

	{
		name = "  Open in terminal",
		hl = "ExRed",
		items = terminal.normal,
	},
}
