-- n, v, i, t = mode names

local function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local mappings = {}

mappings.general = {
	i = {
		["<C-a>"] = { "<ESC>^i", "beginning of line" },
		["<C-e>"] = { "<End>", "end of line" },

		["<A-h>"] = { "<Left>", "move left" },
		["<A-l>"] = { "<Right>", "move right" },
		["<A-j>"] = { "<Down>", "move down" },
		["<A-k>"] = { "<Up>", "move up" },
	},

	n = {
		["<esc>"] = { ":noh <CR>", "clear highlight search" },
		["<C-a>"] = { "ggVG", "select all" },

		["<F11>"] = { ":lua IsView() <CR>", "toggle interface" },
		["<F12>n"] = { ":set norelativenumber!<CR>", "toggle relative number" },
		["<F12>c"] = { ":set list!<CR>", "toggle viewing special character" },
		["<F12>s"] = { ":lua SetGlobalStatusLine()<CR>", "toggle global status line" },

		["<A-.>"] = { ":tabn <CR>", "next tab" },
		["<A-,>"] = { ":tabp <CR>", "previous tab" },
		["<A-c>"] = { ":bd <CR>", "delete tab" },

		["<"] = { "V<gv<ESC>", "tab blockcode backward", opts = { noremap = true, silent = true } },
		[">"] = { "V>gv<ESC>", "tab blockcode forward", opts = { noremap = true, silent = true } },
	},

	t = {
		['<C-t>'] = { "<C-\\><C-n>", "exit terminal mode" },
	},

	v = {
		["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
		["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },

		["<"] = { "<gv", "tab blockcode backward", opts = { noremap = true, silent = true } },
		[">"] = { ">gv", "tab blockcode forward", opts = { noremap = true, silent = true } },
	},

	x = {
		-- Don't copy the replaced text after pasting in visual mode
		["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', opts = { silent = true } },
	},
}

mappings.telescope = {
	plugin = true,
	n = {
		["ff"] = { ":Telescope find_files <CR>", "find files" },
		["fw"] = { ":Telescope live_grep <CR>", "live grep" },
		["f<TAB>"] = { ":Telescope buffers <CR>", "find buffers" },
		["fh"] = { ":Telescope help_tags <CR>", "help page" },
		["fo"] = { ":Telescope oldfiles <CR>", "find oldfiles" },
		["fk"] = { ":Telescope keymaps <CR>", "find oldfiles" },
		["fd"] = { ":Telescope diagnostics <CR>", "find oldfiles" },
		["fr"] = { ":Telescope registers <CR>", "find oldfiles" },
		["fb"] = { ":Telescope file_browser <CR>", "find oldfiles" },
		["fg"] = { ":Telescope git_commits <CR>", "git commits" },
		["fp"] = { ":Telescope project <CR>", "git commits" },
		["fc"] = { ":Telescope neoclip unnamed extra=star,plus,a,b <CR>", "git commits" },
		["fn"] = { ":Telescope noice <CR>", "git commits" },
	},
}

mappings.lspconfig = {
	plugin = true,
	x = {
		["<space>f"] = { ":lua require('lsp-range-format').format() <CR>", "format range", opts = { silent = true } },
	},
}

mappings.lspsaga = {
	plugin = true,
	n = {
		["gf"] = { ":Lspsaga lsp_finder<CR>", "finder", opts = { silent = true } },
		["gr"] = { ":Lspsaga rename<CR>", "rename", opts = { silent = true } },
		["K"] = { ":Lspsaga hover_doc<CR>", "hover doc", opts = { silent = true } },
		["<F6>"] = { ":WindowsDisableAutowidth<CR>:Lspsaga outline<CR>", { silent = true } },
		-- Use <C-t> to jump back
		["gpd"] = { ":Lspsaga peek_definition<CR>", "float definition", opts = { silent = true } },
		-- Diagnsotic jump can use `<c-o>` to jump back
		["gk"] = { ":Lspsaga diagnostic_jump_prev<CR>", "diagnostic jump prev", opts = { silent = true } },
		["gj"] = { ":Lspsaga diagnostic_jump_next<CR>", "diagnostic jump next", opts = { silent = true } },
		-- Only jump to error
		["gek"] = { function() require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR }) end,
			"error jump prev", opts = { silent = true } },
		["gej"] = { function() require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR }) end,
			"error jump next", opts = { silent = true } },
	}
}
-- mappings.terminal = {
-- 	plugin = true,
-- 	n = {
-- 		['<F8>'] = { "<C-\\><C-n>:TermToggle <CR>", "toggle float terminal" },
-- 	},
-- 	t = {
-- 		['<F8>'] = { "<C-\\><C-n>:TermToggle <CR>", "toggle float terminal" },
-- 	},
-- }

return mappings
