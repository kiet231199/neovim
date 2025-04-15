return {
	{
		name = "󰉨  Format Buffer",
		hl = "Exblue",
		cmd = function()
			local ok, rangeformat = pcall(require, "lsp-range-format")

			vim.cmd("normal! gv")
			if ok then
				rangeformat.format()
			else
				vim.lsp.buf.format()
			end
		end,
		rtxt = "gF",
	},


	{ name = "separator" },

	{
		name = "  Align to char",
		hl = "WarningMsg",
		cmd = function()
			vim.cmd"normal! gv"
			require("align").align_to_char({ length = 1 })
		end,
		rtxt = ",ac",
	},

	{
		name = "  Align to string",
		hl = "WarningMsg",
		cmd = function()
			vim.cmd"normal! gv"
			require("align").align_to_string({ preview = true, regex = true })
		end,
		rtxt = ",as",
	},

	{ name = "separator" },

	{
		name = "󰆏  Copy",
		hl = "ExRed",
		cmd = function()
			vim.cmd("normal! gv")
			vim.cmd("normal! y")
		end,
		rtxt = "y",
	},

	{
		name = "  Paste",
		hl = "ExRed",
		cmd = function()
			vim.cmd("normal! gv")
			vim.cmd("normal! p")
		end,
		rtxt = "p",
	},

	{
		name = "  Cut",
		hl = "ExRed",
		cmd = function()
			vim.cmd("normal! gv")
			vim.cmd("normal! d")
		end,
		rtxt = "d",
	},

	{
		name = "  Undo",
		hl = "ExRed",
		cmd = "SelectUndoLine",
		rtxt = "su",
	},
}
