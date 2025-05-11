return {
	{
		name = "󱏒  Open Explorer",
		hl = "WarningMsg",
		cmd = "Neotree toggle reveal_force_cwd",
		rtxt = "F5",
	},

	{
		name = "󰮌  Open Outline",
		hl = "WarningMsg",
		cmd = "Lspsaga outline",
		rtxt = "F6",
	},

	{ name = "separator" },

	{
		name = "  Goto Definition",
		hl = "Exblue",
		cmd = vim.lsp.buf.definition,
		rtxt = "gd",
	},

	{
		name = "  Peek Definition",
		hl = "Exblue",
		cmd = "Lspsaga peek_definition",
		rtxt = "gpd",
	},

	{
		name = "  Show References",
		hl = "Exblue",
		cmd = vim.lsp.buf.references,
		rtxt = "gf",
	},

	{
		name = "󰈙  Show Signature help",
		hl = "Exblue",
		cmd = vim.lsp.buf.signature_help,
	},

	{
		name = "󰧮  Show Hover",
		hl = "Exblue",
		cmd = vim.lsp.buf.hover,
		rtxt = "K",
	},

	{
		name = "  Rename Symbol",
		hl = "Exblue",
		cmd = vim.lsp.buf.rename,
		rtxt = "gr",
	},

	{ name = "separator" },

	{
		name = "  Git Show",
		hl = "DiagnosticInfo",
		cmd = function() require("gitsigns").blame_line({ full = true }) end,
	},

	{
		name = "󰋚  Git Full Blame",
		hl = "DiagnosticInfo",
		cmd = "Gitsigns blame",
	},

	{
		name = "󰕚  Git Diff",
		hl = "DiagnosticInfo",
		cmd = "Gitsigns diffthis",
	},

	{
		name = "󱁊  Git Graph",
		hl = "DiagnosticInfo",
		cmd = function() require("gitgraph").draw({}, { all = true, max_count = 200, exit = true }) end,
	},

	{ name = "separator" },

	{
		name = "  New terminal",
		hl = "ExRed",
		cmd = "TermToggle",
		rtxt = "F8",
	},
	{
		name = "󰕮  Htop",
		hl = "ExRed",
		cmd = "Htop",
	},
	{
		name = "  Lazygit",
		hl = "ExRed",
		cmd = "Lazygit",
	},

	{ name = "separator" },

	{
		name = "  Add breakpoint",
		hl = "ErrorMsg",
		cmd = function() require('persistent-breakpoints.api').toggle_breakpoint() end,
		rtxt = "Shift+F9",
	},
}
