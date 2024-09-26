return {
	normal = {
		{
			name = "Show References",
			cmd = vim.lsp.buf.references,
			rtxt = "gf",
		},

		{
			name = "Goto Definition",
			cmd = vim.lsp.buf.definition,
			rtxt = "gd",
		},

		{
			name = "Show Signature help",
			cmd = vim.lsp.buf.signature_help,
			rtxt = "gs",
		},

		{
			name = "Show Hover",
			cmd = vim.lsp.buf.hover,
			rtxt = "K",
		},
	},

	visual = {
		{
			name = "Format Buffer",
			cmd = function()
				local ok, rangeformat = pcall(require, "lsp-range-format")

				vim.cmd "normal! gv"
				if ok then
					rangeformat.format()
				else
					vim.lsp.buf.format()
				end
			end,
			rtxt = "gF",
		},
	}
}
