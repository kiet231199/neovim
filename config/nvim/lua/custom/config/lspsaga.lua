local keymap = vim.keymap.set
local saga = require('lspsaga')

saga.setup({
	preview = {
		lines_above = 0,
		lines_below = 10,
	},
	scroll_preview = {
		scroll_down = '<C-d>',
		scroll_up = '<C-u>',
	},
	request_timeout = 2000,
	finder = {
		max_height = 0.6,
		min_width = 30,
		force_max_height = false,
		keys = {
			jump_to = 'p',
			expand_or_jump = '<CR>',
			vsplit = 'v',
			split = 'h',
			tabe = 't',
			tabnew = 'r',
			quit = { 'q', '<ESC>' },
			close_in_preview = '<ESC>',
		},
	},
	definition = {
		edit = 'o',
		vsplit = 'v',
		split = 'h',
		tabe = 't',
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
		enable = false,
		enable_in_insert = true,
		sign = true,
		sign_priority = 40,
		virtual_text = true,
	},
	diagnostic = {
		on_insert = false,
		on_insert_follow = false,
		insert_winblend = 0,
		show_code_action = false,
		show_source = true,
		jump_num_shortcut = true,
		max_width = 0.7,
		max_height = 0.6,
		max_show_width = 0.9,
		max_show_height = 0.6,
		text_hl_follow = true,
		border_follow = true,
		extend_relatedInformation = true,
		keys = {
			exec_action = 'o',
			quit = 'q',
			go_action = 'g',
			expand_or_jump = '<CR>',
			quit_in_show = { 'q', '<ESC>' },
		},
	},
	hover = {
		max_width = 0.6,
		open_link = 'gx',
		open_browser = '!chrome',
	},
	rename = {
		quit = '<C-c>',
		exec = '<CR>',
		mark = 'x',
		confirm = '<CR>',
		in_select = true,
	},
	outline = {
		win_position = 'right',
		win_with = '',
		win_width = 40,
		preview_width = 0.6;
		show_detail = true,
		auto_preview = true,
		auto_refresh = true,
		auto_close = false,
		custom_sort = nil,
		keys = {
			expand_or_jump= '<CR>',
			quit = 'q',
		},
	},
	callhierarchy = {
		show_detail = true,
		keys = {
			edit = "e",
			vsplit = "s",
			split = "i",
			tabe = "t",
			jump = "o",
			quit = "q",
			expand_collapse = "u",
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
		 -- This option only works in Neovim 0.9
		title = true,
		-- Border type can be single, double, rounded, solid, shadow.
		border = "rounded",
		winblend = 10,
		expand = "",
		collapse = "",
		code_action = "💡",
		incoming = " ",
		outgoing = " ",
		hover = ' ',
		kind = {
			['String'] = { ' ', 'String' },
			['Array'] = { ' ', 'Type' },
			['Null'] = { ' ', 'Constant' },
			['Function'] = { ' ', 'Function' },
		},
	},
})
