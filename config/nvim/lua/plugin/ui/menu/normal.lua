local editor   = require("plugin.ui.menu.editor")
local lsp      = require("plugin.ui.menu.lsp")
local terminal = require("plugin.ui.menu.terminal")

return {
	{
		name = "󱏒  Open Explorer",
		cmd = function() require("snacks").explorer() end,
	},

	{
		name = "󰮌  Open Outline",
		cmd = "Lspsaga outline",
	},

	{ name = "separator" },

	{
		name = "  Lsp Actions",
		hl = "Exblue",
		items = lsp.normal,
	},

	{ name = "separator" },

	{
		name = "󰩍  Load Session"
	},

	{
		name = "  Save Session"
	},

	{
		name = "󱀷  Delete Session"
	},

	{ name = "separator" },

	{
		name = "  Open in terminal",
		hl = "ExRed",
		items = terminal.normal,
	},
}
