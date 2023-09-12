-- n, v, i, t = mode names

local function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local mappings = {}

mappings.general = {
	i = {
		["<C-a>"] = { "<ESC>^i", "beginning of line" },

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

		["<A-Up>"] = { ":resize -2 <CR>", "Resize up" },
		["<A-Down>"] = { ":resize +2 <CR>", "Resize down" },
		["<A-Left>"] = { ":vertical resize -2 <CR>", "Resize left" },
		["<A-Right>"] = { ":vertical resize +2 <CR>", "Resize right" },

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

mappings.gitsigns = {
	plugin = true,
	n = {
		["<F9>"] = { ":Gitsigns toggle_current_line_blame <CR>", "toggle blame line" },
	},
	i = {
		["<F9>"] = { ":Gitsigns toggle_current_line_blame <CR>", "toggle blame line" },
	},
}

mappings.telescope = {
	plugin = true,
	n = {
		["<space>ff"] = { ":Telescope find_files <CR>", "find files" },
		["<space>fw"] = { ":Telescope live_grep <CR>", "live grep" },
		["<space>f<TAB>"] = { ":Telescope buffers <CR>", "find buffers" },
		["<space>fh"] = { ":Telescope help_tags <CR>", "help page" },
		["<space>fo"] = { ":Telescope oldfiles <CR>", "find oldfiles" },
		["<space>fk"] = { ":Telescope keymaps <CR>", "find oldfiles" },
		["<space>fd"] = { ":Telescope diagnostics <CR>", "find oldfiles" },
		["<space>fr"] = { ":Telescope registers <CR>", "find oldfiles" },
		["<space>fb"] = { ":Telescope file_browser <CR>", "find oldfiles" },
		["<space>fg"] = { ":Telescope git_commits <CR>", "git commits" },
		["<space>fp"] = { ":Telescope project <CR>", "git commits" },
	},
}

mappings.lspconfig = {
	plugin = true,
	x = {
		["<space>f"] = { ":lua require('lsp-range-format').format() <CR>", "format range", opts = { silent = true } },
	},
}

mappings.terminal = {
	plugin = true,
	n = {
		['<F8>'] = { "<C-\\><C-n>:TermToggle <CR>", "toggle float terminal" },
	},
	t = {
		['<F8>'] = { "<C-\\><C-n>:TermToggle <CR>", "toggle float terminal" },
	},
}

mappings.tabout = {
	plugin = true,
	i = {
		["<C-Right>"] = { "<Plug>(Tabout)", "tabout next", opts = { silent = true } },
		["<C-Left>"] = { "<Plug>(TaboutBack)", "tabout previous", opts = { silent = true } },
	},
}

mappings.searchbox = {
	plugin = true,
	n = {
		["<A-f>"] = { ":SearchBoxIncSearch title=Search<CR>", "search" },
		["<A-S-f>"] = { ":SearchBoxIncSearch title=Search -- <C-r>=expand('<cword>') <CR><CR>", "search" },
		["<A-r>"] = { ":SearchBoxReplace title=Replace confirm=menu<CR>", "search" },
		["<A-S-r>"] = { ":SearchBoxReplace title=Replace confirm=menu -- <C-r>=expand('<cword>') <CR><CR>", "search" },
	},
	v = {
		["<A-f>"] = { ":SearchBoxIncSearch title=Search visual_mode=true<CR>", "search" },
		["<A-S-f>"] = { ":SearchBoxIncSearch title=Search visual_mode=true -- <C-r>=expand('<cword>') <CR><CR>", "search" },
		["<A-r>"] = { ":SearchBoxReplace title=Replace visual_mode=true confirm=menu<CR>", "search" },
		["<A-S-r>"] = { ":SearchBoxReplace title=Replace visual_mode=true confirm=menu -- <C-r>=expand('<cword>') <CR><CR>", "search" },
	},
}

mappings.lspsaga = {
	plugin = true,
	n = {
		["gf"] = { ":Lspsaga finder def+ref<CR>", "finder", opts = { silent = true } },
		["gi"] = { ":Lspsaga finder imp<CR>", "implement", opts = { silent = true } },
		["gr"] =  { ":Lspsaga rename<CR>", "rename", opts = { silent = true } },
		["K"] = { ":Lspsaga hover_doc<CR>", "hover doc", opts = { silent = true } },
		["<F6>"] = { ":Lspsaga outline<CR>", opts = { silent = true } },
		-- Use <C-t> to jump back
		["gpd"] = { ":Lspsaga peek_definition<CR>", "float definition", opts = { silent = true } },
		-- Diagnsotic jump can use `<c-o>` to jump back
		["gk"] = { function() require("lspsaga.diagnostic"):goto_prev() end, "diagnostic jump prev", opts = { silent = true } },
		["gj"] = { function() require("lspsaga.diagnostic"):goto_next() end, "diagnostic jump next", opts = { silent = true } },
		-- Only jump to error
		["gek"] = { function() require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, "error jump prev", opts = { silent = true } },
		["gej"] = { function() require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR }) end, "error jump next", opts = { silent = true } },
	}
}

mappings.dropbar = {
	plugin = true,
	n = {
		["<space>ww"] = { function() require("dropbar.api").pick() end, "pick winbar element", opts = { silent = true } },
	}
}

mappings.session = {
	plugin = true,
	n = {
		["<space>sl"] = { ":SessionManager load_last_session<CR>", "Load last session", opts = { silent = true, noremap = true } },
		["<space>ss"] = { ":SessionManager save_current_session<CR>", "Save current session", opts = { silent = true, noremap = true } },
		["<space>sd"] = { ":SessionManager load_last_session<CR>", "Delete session", opts = { silent = true, noremap = true } },
	}
}

return mappings
