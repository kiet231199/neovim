return {
	visual = {
		{
			name = "󰆏  Copy",
			cmd = function()
				vim.cmd("normal! gv")
				vim.cmd("normal! y")
			end,
		},

		{
			name = "  Paste",
			cmd = function()
				vim.cmd("normal! gv")
				vim.cmd("normal! p")
			end,
		},

		{
			name = "  Cut",
			cmd = function()
				vim.cmd("normal! gv")
				vim.cmd("normal! d")
			end,
		},
	}
}
