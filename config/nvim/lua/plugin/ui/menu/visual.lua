local editor = require("plugin.ui.menu.editor")
local lsp = require("plugin.ui.menu.lsp")

return {
	{
		name = "󰆏  Copy absolute path",
		cmd = "%y+",
	},

	{
		name = "  Paste",
		cmd = "p",
	},

	{
		name = "  Undo",
		cmd = "SelectUndoLine"
	},

	{ name = "separator" },
	{
		name = "  Lsp Actions",
		hl = "Exblue",
		items = lsp.visual,
	},
}
