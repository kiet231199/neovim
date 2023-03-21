-- n, v, i, t = mode names

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
		["<esc>"] = { "<cmd> noh <CR>", "clear highlight search" },
		["<C-a>"] = { "ggVG", "select all" },

		["<F11>"] = { "<cmd> set rnu! <CR>", "toggle interface" },
		["<F12>n"] = { "<cmd> set norelativenumber!<CR>", "toggle relative number" },
		["<F12>c"] = { "<cmd> set list!<CR>", "toggle viewing special character" },
		["<F12>s"] = { "<cmd> lua SetGlobalStatusLine()<CR>", "toggle global status line" },

		["<A-.>"] = { "<cmd> tabn <CR>", "next tab" },
		["<A-,>"] = { "<cmd> tabp <CR>", "previous tab" },
		["<A-c>"] = { "<cmd> bd <CR>", "delete tab" },

		["te"] = { "<cmd> tabedit", "new tab" },
		["sh"] = { "<cmd> split <CR><C-w>w", "split pane horizontally" },
		["sv"] = { "<cmd> vsplit <CR><C-w>w", "split pane vertically" },

		["dv"] = { "<cmd> diffsplit", "diffview file" },

		["<A-Up>"] = { "<cmd> resize -2 <CR>", "Resize up" },
		["<A-Down>"] = { "<cmd> resize +2 <CR>", "Resize down" },
		["<A-Left>"] = { "<cmd> vertical resize -2 <CR>", "Resize left" },
		["<A-Right>"] = { "<cmd> vertical resize +2 <CR>", "Resize right" },
	},

	t = {
		["<C-k>"] = { "<C-\\><C-N><C-w>k", "Move to up pane", opts = { silent = true } },
		["<C-j>"] = { "<C-\\><C-N><C-w>j", "Move to down pane", opts = { silent = true } },
		["<C-h>"] = { "<C-\\><C-N><C-w>h", "Move to left pane", opts = { silent = true } },
		["<C-l>"] = { "<C-\\><C-N><C-w>l", "Move to right pane", opts = { silent = true } },
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
		["<F9>"] = { "<cmd> Gitsigns toogle_current_line_blame <CR>", "toggle blame line" },
	},
	i = {
		["<F9>"] = { "<cmd> Gitsigns toogle_current_line_blame <CR>", "toggle blame line" },
	},
}

mappings.telescope = {
	plugin = true,
	n = {
		["ff"] = { "<cmd> Telescope find_files <CR>", "find files" },
		["fw"] = { "<cmd> Telescope live_grep <CR>", "live grep" },
		["f<TAB>"] = { "<cmd> Telescope buffers <CR>", "find buffers" },
		["fh"] = { "<cmd> Telescope help_tags <CR>", "help page" },
		["fo"] = { "<cmd> Telescope oldfiles <CR>", "find oldfiles" },
		["fk"] = { "<cmd> Telescope keymaps <CR>", "find oldfiles" },
		["fd"] = { "<cmd> Telescope diagnostics <CR>", "find oldfiles" },
		["fr"] = { "<cmd> Telescope registers <CR>", "find oldfiles" },
		["fb"] = { "<cmd> Telescope file_browser <CR>", "find oldfiles" },
		["fg"] = { "<cmd> Telescope git_commits <CR>", "git commits" },
		["fp"] = { "<cmd> Telescope project <CR>", "git commits" },
		["fc"] = { "<cmd> Telescope neoclip unnamed extra=star,plus,a,b <CR>", "git commits" },
		["fn"] = { "<cmd> Telescope noice <CR>", "git commits" },
	},
}

mappings.lspconfig = {
	plugin = true,
	x = {
		["<space>f"] = { "<cmd> lua require('lsp-range-format').format() <CR>", "format range", opts = { silent = true } },
	},
}

mappings.searchreplace = {
	plugin = true,
	v = {
		['<leader>ra'] = { "<cmd> SearchReplaceWithinVisualSelection <CR>", "search replace visual" },
		['<leader>rc'] = { "<cmd> SearchReplaceWithinVisualSelectionCWord <CR>", "search replace visual" },
	},
}

mappings.himywords = {
	plugin = true,
	n = {
		['<space>m'] = { "<cmd> HiMyWordsToggle <CR>", "highlight word on cursor" },
		['<space>M'] = { "<cmd> HiMyWordsClear <CR>", "clear all highlight" },
	},
}

mappings.toggleterm = {
	plugin = true,
	t = {
		['<C-t>'] = { "<C-\\><C-n>", "exit terminal mode" },
		['<F8>'] = { "<cmd> ToggleTerm <CR>", "toggle float terminal" },
		['<C-Up>'] = { "<cmd> ToggleTerm <CR> <cmd> ToggleTerm direction=float <CR>", "toggle float terminal" },
		['<C-Down>'] = { "<cmd> ToggleTerm <CR> <cmd> ToggleTerm direction=horizontal <CR>", "toggle float terminal" },
		['<C-Left>'] = { "<cmd> ToggleTerm <CR> <cmd> ToggleTerm direction=tab <CR>", "toggle float terminal" },
		['<C-Right>'] = { "<cmd> ToggleTerm <CR> <cmd> ToggleTerm direction=vertical <CR>", "toggle float terminal" },
	},
}

mappings.notify = {
	plugin = true,
	n = {
		["<C-s>"] = { '<cmd>w<CR>:lua require("notify")("Save successfull 勒", "info",{title = "Save file "})<CR><cmd>noh<CR>', opts = { silent = true } },
	},
}

mappings.tabout = {
	plugin = true,
	i = {
		["<C-l>"] = { "<Plug>(Tabout)", "tabout next", opts = { silent = true } },
		["<C-h>"] = { "<Plug>(TaboutBack)", "tabout previous", opts = { silent = true } },
	},
}

mappings.move = {
	plugin = true,
	n = {
		["<A-j>"] = { "<cmd> MoveLine(1) <CR>", "move block down" },
		["<A-k>"] = { "<cmd> MoveLine(-1) <CR>", "move block up" },
		["<A-h>"] = { "<cmd> MoveHChar(-1) <CR>", "move block left" },
		["<A-l>"] = { "<cmd> MoveHChar(1) <CR>", "move block right" },
	},
	v = {
		["<A-j>"] = { "<cmd> MoveBlock(1) <CR>", "move block down" },
		["<A-k>"] = { "<cmd> MoveBlock(-1) <CR>", "move block up" },
		["<A-h>"] = { "<cmd> MoveHBlock(-1) <CR>", "move block left" },
		["<A-l>"] = { "<cmd> MoveHBlock(1) <CR>", "move block right" },
	},
}

mappings.searchbox = {
	plugin = true,
	n = {
		["<A-f>"] = { "<cmd> SearchBoxIncSearch title=Search<CR>", "search" },
		["<A-S-f>"] = { "<cmd> SearchBoxIncSearch title=Search -- <C-r>=expand('<cword>') <CR><CR>", "search" },
		["<A-r>"] = { "<cmd> SearchBoxReplace title=Replace confirm=menu<CR>", "search" },
		["<A-S-r>"] = { "<cmd> SearchBoxReplace title=Replace confirm=menu -- <C-r>=expand('<cword>') <CR><CR>", "search" },
	},
	v = {
		["<A-f>"] = { "<cmd> SearchBoxIncSearch title=Search visual_mode=true<CR>", "search" },
		["<A-S-f>"] = { "<cmd> SearchBoxIncSearch title=Search visual_mode=true -- <C-r>=expand('<cword>') <CR><CR>", "search" },
		["<A-r>"] = { "<cmd> SearchBoxReplace title=Replace visual_mode=true confirm=menu<CR>", "search" },
		["<A-S-r>"] = { "<cmd> SearchBoxReplace title=Replace visual_mode=true confirm=menu -- <C-r>=expand('<cword>') <CR><CR>", "search" },
	},
}

return mappings
