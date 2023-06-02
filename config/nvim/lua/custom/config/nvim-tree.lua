local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	print("Error: nvim-tree")
	return
end

local function on_attach(bufnr)
	local api = require('nvim-tree.api')
	local function opts(desc)
		return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end
	-- You will need to insert "your code goes here" for any mappings with a custom action_cb
	vim.keymap.set('n', '<space>',        api.node.show_info_popup, opts('Info'))
	vim.keymap.set('n', '<CR>',           api.node.open.edit, opts('Open'))
	vim.keymap.set('n', 'o',              api.node.open.edit, opts('Open'))
	vim.keymap.set('n', '<2-LeftMouse>',  api.node.open.edit, opts('Open'))
	vim.keymap.set('n', '<BS>',           api.tree.change_root_to_node, opts('CD'))
	vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
	vim.keymap.set('n', 'sv',             api.node.open.vertical, opts('Open: Vertical Split'))
	vim.keymap.set('n', 'ss',             api.node.open.horizontal, opts('Open: Horizontal Split'))
	vim.keymap.set('n', 'n',              api.node.open.tab, opts('Open: New Tab'))
	vim.keymap.set('n', '<',              api.node.navigate.sibling.prev, opts('Previous Sibling'))
	vim.keymap.set('n', '>',              api.node.navigate.sibling.next, opts('Next Sibling'))
	vim.keymap.set('n', 'P',              api.node.navigate.parent, opts('Parent Directory'))
	vim.keymap.set('n', 'v',              api.node.open.preview, opts('Open Preview'))
	vim.keymap.set('n', 'R',              api.tree.reload, opts('Refresh'))
	vim.keymap.set('n', 'a',              api.fs.create, opts('Create'))
	vim.keymap.set('n', 'd',              api.fs.remove, opts('Delete'))
	vim.keymap.set('n', 'D',              api.fs.trash, opts('Trash'))
	vim.keymap.set('n', 'r',              api.fs.rename, opts('Rename'))
	vim.keymap.set('n', '<C-r>',          api.fs.rename_sub, opts('Rename: Omit Filename'))
	vim.keymap.set('n', 'x',              api.fs.cut, opts('Cut'))
	vim.keymap.set('n', 'c',              api.fs.copy.node, opts('Copy'))
	vim.keymap.set('n', 'p',              api.fs.paste, opts('Paste'))
	vim.keymap.set('n', 'y',              api.fs.copy.filename, opts('Copy Name'))
	vim.keymap.set('n', 'Y',              api.fs.copy.relative_path, opts('Copy Relative Path'))
	vim.keymap.set('n', 'gy',             api.fs.copy.absolute_path, opts('Copy Absolute Path'))
	vim.keymap.set('n', 'q',              api.tree.close, opts('Close'))
end

nvim_tree.setup({
	on_attach = on_attach,
	remove_keymaps = true, -- boolean (disable totally or not) or list of key (lhs)
	view = {
		adaptive_size = true,
		centralize_selection = false,
		width = { min = 50, max = 100, padding = 5 },
		hide_root_folder = false,
		side = "left",
		preserve_window_proportions = false,
		number = false,
		relativenumber = true,
		signcolumn = "yes",
	},
	renderer = {
		add_trailing = true,
		group_empty = true,
		highlight_git = true,
		full_name = false,
		highlight_opened_files = "all",
		root_folder_modifier = ":~",
		indent_width = 2,
		indent_markers = {
			enable = true,
			inline_arrows = true,
			icons = {
				corner = "╰",
				edge = "│",
				item = "├",
				bottom = "─",
				none = " ",
			},
		},
		icons = {
			webdev_colors = true,
			git_placement = "signcolumn",
			padding = " ",
			symlink_arrow = "  ",
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},
			glyphs = {
				default = "",
				symlink = "",
				bookmark = "",
				folder = {
					-- arrow_closed = "",
					arrow_closed = "",
					-- arrow_open = "",
					arrow_open = "",
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
				git = {
					unstaged = "",
					staged = "",
					unmerged = "",
					renamed = "",
					untracked = "❌",
					deleted = "",
					ignored = "",
				},
			},
		},
		special_files = { "Makefile", "README.md", "readme.md", "CMakeLists.txt" },
		symlink_destination = true,
	},
	update_focused_file = {
		enable = false,
		update_root = true,
		ignore_list = { "help" },
	},
	system_open = {
		cmd = "",
		args = {},
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
		debounce_delay = 50,
		icons = {
			hint = " ",
			info = " ",
			warning = " ",
			error = " ",
		},
	},
	filters = {
		dotfiles = false,
		custom = { "*.o", "*.lo" },
		exclude = {},
	},
	filesystem_watchers = {
		enable = true,
		debounce_delay = 50,
	},
	git = {
		enable = true,
		ignore = false,
		show_on_dirs = true,
		timeout = 300,
	},
	actions = {
		use_system_clipboard = true,
		change_dir = {
			enable = true,
			global = false,
			restrict_above_cwd = false,
		},
		expand_all = {
			max_folder_discovery = 300,
			exclude = {},
		},
		file_popup = {
			open_win_config = {
				col = 1,
				row = 1,
				relative = "cursor",
				border = "rounded",
				style = "minimal",
			},
		},
		open_file = {
			quit_on_open = false,
			resize_window = true,
			window_picker = {
				enable = true,
				chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
				exclude = {
					filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
					buftype = { "nofile", "terminal", "help" },
				},
			},
		},
		remove_file = {
			close_window = true,
		},
	},
	trash = {
		cmd = "gio trash",
		require_confirm = true,
	},
	live_filter = {
		prefix = "[FILTER]: ",
		always_show_folders = true,
	},
	log = {
		enable = false,
		truncate = false,
		types = {
			all = false,
			config = false,
			copy_paste = false,
			dev = false,
			diagnostics = false,
			git = false,
			profile = false,
			watcher = false,
		},
	},
})

