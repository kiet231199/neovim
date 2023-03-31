local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	print("Error: telescope")
	return
end

telescope.setup({
	defaults = {
		-- Default configuration for telescope goes here:
		-- config_key = value,
		-- other layout configuration here
		prompt_prefix = '🔍: ',
		initial_mode = "insert",
		selection_strategy = "reset",
		layout_config = {
			center = {
				prompt_position = "top",
				scroll_speed = 5,
			},
			horizontal = {
				prompt_position = "top",
				preview_width = 0.6,
				results_width = 0.4,
				scroll_speed = 5,
			},
			vertical = {
				mirror = false,
			},
			width = 0.95,
			height = 0.9,
			preview_cutoff = 120,
		},
		winblend = 12,
		color_devicons = true,
		set_env = { ["COLORTERM"] = "truecolor" },
		preview = {
			treesitter = true,
		},
		history = {
			path = vim.g.data_path .. "/telescope_history"
		},
	},
	mappings = {
		-- i = { ["<C-t>"] = trouble.open_with_trouble },
		-- n = { ["<C-t>"] = trouble.open_with_trouble },
	},
	pickers = {
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now telescope.nvim@ene picker_config_key will be applied every time you call this
	},
	extensions = {
		-- Your extension configuration goes here:
		fzf = {
			fuzzy = true,                    -- false will only do exact matching
			override_generic_sorter = true,  -- override the generic sorter
			override_file_sorter = true,     -- override the file sorter
			case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
		file_browser = {
			layout_strategies = "horizontal",
			prompt_title = 'File Browser',
			-- theme = "ivy",
			-- disables netrw and use telescope-file-browser in its place
		},
		project = {
			base_dirs = {
				{ path = '~', max_depth = 4 },
			},
			hidden_files = true, -- default: false
			theme = "dropdown",
			order_by = "asc",
			sync_with_nvim_tree = true, -- default false

		},
		["ui-select"] = {
			require("telescope.themes").get_dropdown()
		},
		command_palette = {
			{ "Git",
				{ "VGit buffer hunk preview", ':VGit buffer_hunk_preview ' },
				{ "VGit buffer diff preview", ':VGit buffer_diff_preview ' },
				{ "VGit buffer history preview", ':VGit buffer_history_preview ' },
				{ "VGit buffer blame preview", ':VGit buffer_blame_preview ' },
				{ "VGit buffer gutter blame preview", ':VGit buffer_gutter_blame_preview ' },
			},
			{ "Vim",
				{ "Toggle Auto Width", 'WindowsToggleAutowidth' },
				{ "Change to view mode (F11)", ':lua isView()' },
				{ "Reload vimrc", ":source $MYVIMRC" },
				{ 'Check health', ":checkhealth" },
			},
			{ "Telescope",
				{ "Project", 'Telescope project' },
				{ "Icon Picker", 'IconPickerInsert' },
				{ "Color Picker", 'PickColor' },
				{ "Diagnostics", ':Telescope diagnostics' },
				{ "Git commits", ':Telescope git_commits' },
				{ "Todo comment", ':Telescope keyword=TODO,FIX,ERROR,HACK,NOTE,WARNING' },
			},
			{ "LSP",
				{ "Toggle LSP", 'ToggleLSP' },
				{ "Toggle Null LSP", 'ToggleNullLSP' },
			},
		}
	}
})

-- load extensions
telescope.load_extension('file_browser')
if vim.fn.has("win32") == 0 then telescope.load_extension('fzf') end
telescope.load_extension('project')
telescope.load_extension('ui-select')
telescope.load_extension('find_pickers')
telescope.load_extension('command_palette')
telescope.load_extension("neoclip")
