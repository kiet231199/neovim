local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	print("Error: telescope")
	return
end

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(require("telescope.config").values.vimgrep_arguments) }
-- Search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- Do not search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

local history_path = ""
if vim.fn.has("unix") == 1 then
	history_path = vim.g.data_path .. "/telescope_history"
else
	-- Don't need to care about memory in window :3
	history_path = vim.fn.stdpath("data") .. "/telescope_history"
end

local utils = require("plugin.telescope.utils")
local actions = require("telescope.actions")

local mappings = {
	i = {
		["<C-f>"] = actions.nop,
		["<C-k>"] = actions.nop,
		["<M-f>"] = actions.nop,
		["<M-k>"] = actions.nop,
		["<C-u>"] = utils.previewer_scroll_up,
		["<C-d>"] = utils.previewer_scroll_down,
		["<C-r>"] = utils.previewer_scroll_right,
		["<C-l>"] = utils.previewer_scroll_left,
		["<M-u>"] = actions.results_scrolling_up,
		["<M-d>"] = actions.results_scrolling_down,
		["<M-r>"] = actions.results_scrolling_right,
		["<M-l>"] = actions.results_scrolling_left,
	},
}

telescope.setup({
	defaults = {
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
        -- create_layout = function(picker)
        --     local layout = require("plugin.finder.layout").get_layout(picker)
        --     return require("telescope.pickers.layout")(layout)
        -- end,
		winblend = 0,
		color_devicons = true,
		set_env = { ["COLORTERM"] = "truecolor" },
		preview = {
			treesitter = true,
		},
		history = {
			path = history_path,
		},
		vimgrep_arguments = vimgrep_arguments,
		-- Do not preview binary
		buffer_previewer_maker = function(filepath, bufnr, opts)
			filepath = vim.fn.expand(filepath)
			require("plenary.job"):new({
				command = "file",
				args = { "--mime-type", "-b", filepath },
				on_exit = function(j)
					local mime_type = vim.split(j:result()[1], "/")[1]
					if mime_type == "text" then
						require("telescope.previewers").buffer_previewer_maker(filepath, bufnr, opts)
					else
						-- maybe we want to write something to the buffer here
						vim.schedule(function()
							vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
						end)
					end
				end
			}):sync()
		end,
		mappings = mappings,
	},
	pickers = {
		find_files = {
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
		},
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
		},
	}
})

-- load extensions
telescope.load_extension('file_browser')
if vim.fn.has("unix") == 1 then telescope.load_extension('fzf') end
telescope.load_extension('project')
telescope.load_extension('ui-select')
telescope.load_extension('find_pickers')
telescope.load_extension('command_palette')
telescope.load_extension("neoclip")
