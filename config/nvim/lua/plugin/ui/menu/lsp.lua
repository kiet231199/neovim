return {
	normal = {
		{
			name = "  Show References",
			cmd = vim.lsp.buf.references,
		},

		{
			name = "  Goto Definition",
			cmd = vim.lsp.buf.definition,
		},

		{
			name = "󰈙  Show Signature help",
			cmd = vim.lsp.buf.signature_help,
		},

		{
			name = "󰧮  Show Hover",
			cmd = vim.lsp.buf.hover,
		},
	},

	visual = {
		{
			name = "󰉨  Format Buffer",
			cmd = function()
				local ok, rangeformat = pcall(require, "lsp-range-format")

				vim.cmd "normal! gv"
				if ok then
					rangeformat.format()
				else
					vim.lsp.buf.format()
				end
			end,
		},
	}
}
