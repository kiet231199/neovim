local keymap = vim.keymap.set
local saga = require('lspsaga')

saga.setup({
	preview = {
		lines_above = 0,
		lines_below = 10,
	},
	scroll_preview = {
		scroll_down = '<C-f>',
		scroll_up = '<C-b>',
	},
	request_timeout = 2000,
	finder = {
		edit = { 'o', '<CR>' },
		vsplit = 'v',
		split = 'h',
		tabe = 't',
		quit = { 'q', '<ESC>' },
	},
	definition = {
		edit = '<C-c>o',
		vsplit = '<C-c>v',
		split = '<C-c>h',
		tabe = '<C-c>t',
		quit = 'q',
		close = '<Esc>',
	},
	code_action = {
		num_shortcut = true,
		keys = {
			-- string |table type
			quit = 'q',
			exec = '<CR>',
		},
	},
	lightbulb = {
		enable = true,
		enable_in_insert = true,
		sign = true,
		sign_priority = 40,
		virtual_text = true,
	},
	diagnostic = {
		show_code_action = true,
		show_source = true,
		jump_num_shortcut = true,
		keys = {
			exec_action = 'o',
			quit = 'q',
			go_action = 'g'
		},
	},
	rename = {
		quit = '<C-c>',
		exec = '<CR>',
		mark = 'x',
		confirm = '<CR>',
		in_select = true,
		whole_project = true,
	},
	outline = {
		win_position = 'right',
		win_with = '',
		win_width = 40,
		show_detail = true,
		auto_preview = true,
		auto_refresh = true,
		auto_close = true,
		custom_sort = nil,
		keys = {
			jump = 'o',
			expand_collapse = 'u',
			quit = 'q',
		},
	},
	symbol_in_winbar = {
		enable = true,
		separator = '  ',
		hide_keyword = true,
		show_file = true,
		folder_level = 2,
		respect_root = false,
		color_mode = true,
	},
	ui = {
		-- currently only round theme
		theme = 'round',
		-- this option only work in neovim 0.9
		title = true,
		-- border type can be single,double,rounded,solid,shadow.
		border = 'rounded',
		winblend = 10,
		expand = '',
		collapse = '',
		preview = ' ',
		code_action = '💡',
		diagnostic = '🐞',
		incoming = ' ',
		outgoing = ' ',
		colors = {
			--float window normal background color
			-- normal_bg = '#1d1536',
			normal_bg = '#16161E',
			--title background color
			title_bg = '#afd700',
			red = '#e95678',
			magenta = '#b33076',
			orange = '#FF8700',
			yellow = '#f7bb3b',
			green = '#afd700',
			cyan = '#36d0e0',
			blue = '#61afef',
			purple = '#CBA6F7',
			white = '#d1d4cf',
			black = '#1c1c19',
		},
		kind = {},
	},
})

-- Finder
keymap("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
-- Code action
keymap({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
-- Rename
keymap("n", "gr", "<cmd>Lspsaga rename<CR>", { silent = true })
-- Peek Definition
keymap("n", "gpd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
-- Show line diagnostics
keymap("n", "go", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
-- Show cursor diagnostic
keymap("n", "go", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })
-- Diagnsotic jump can use `<c-o>` to jump back
keymap("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
keymap("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
-- Only jump to error
keymap("n", "gek", function()
	require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
keymap("n", "gej", function()
	require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
-- Hover Doc
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
-- Outline
keymap("n", "<F6>", "<cmd>WindowsDisableAutowidth<CR><cmd>Lspsaga outline<CR>",{ silent = true })
