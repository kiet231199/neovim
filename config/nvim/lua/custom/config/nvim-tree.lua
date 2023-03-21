local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	print("Error: nvim-tree")
	return
end

nvim_tree.setup({
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
		-- @deprecated
		mappings = {
			custom_only = true,
			list = {
				-- user mappings go here
				{ key = "<space>",							action = "toggle_file_info" },
				{ key = { "<CR>", "o", "<2-LeftMouse>" }, 	action = "edit" },
				{ key = { "<BS>", "<2-RightMouse>" },		action = "cd" },
				{ key = "sv",								action = "vsplit" },
				{ key = "ss",								action = "split" },
				{ key = "n",								action = "tabnew" },
				{ key = "<",								action = "prev_sibling" },
				{ key = ">",								action = "next_sibling" },
				{ key = "P",								action = "parent_node" },
				{ key = "v",								action = "preview" },
				{ key = "R",								action = "refresh" },
				{ key = "a",								action = "create" },
				{ key = "d",								action = "remove" },
				{ key = "D",								action = "trash" },
				{ key = "r",								action = "rename" },
				{ key = "<C-r>",							action = "full_rename" },
				{ key = "x",								action = "cut" },
				{ key = "c",								action = "copy" },
				{ key = "p",								action = "paste" },
				{ key = "y",								action = "copy_name" },
				{ key = "Y",								action = "copy_path" },
				{ key = "gy",								action = "copy_absolute_path" },
				{ key = "q",								action = "close" },
			},
		},
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
			symlink_arrow = "  ",
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
					arrow_closed = "",
					-- arrow_open = "",
					arrow_open = "",
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
				git = {
					unstaged = "",
					staged = "",
					unmerged = "",
					renamed = "",
					untracked = "",
					deleted = "",
					ignored = "",
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
			hint = " ",
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

