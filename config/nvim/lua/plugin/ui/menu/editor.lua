return {
	normal = {

		{
			name = "Copy absolute path",
		},

		{
			name = "Paste",
			cmd = "p",
			rtxt = "p",
		},
	},

	visual = {
		{
			name = "Copy",
			cmd = function()
				vim.cmd("normal! gv")
				vim.cmd("normal! y")
			end,
			rtxt = "y",
		},

		{
			name = "Paste",
			cmd = function()
				vim.cmd("normal! gv")
				vim.cmd("normal! p")
			end,
			rtxt = "p",
		},

		{
			name = "Cut",
			cmd = function()
				vim.cmd("normal! gv")
				vim.cmd("normal! d")
			end,
			rtxt = "d",
		},
	}
}
