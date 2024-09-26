local editor = require("plugin.ui.menu.editor")
local lsp = require("plugin.ui.menu.lsp")

return {
	{
		name = "  Editor",
		hl = "Exyellow",
		items = editor.visual,
	},

	{ name = "separator" },
	{
		name = "  Lsp Actions",
		hl = "Exblue",
		items = lsp.visual,
	},
}
