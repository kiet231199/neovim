local status_ok, flash = pcall(require, "flash")
if not status_ok then
	print("Error: flash")
	return
end

flash.setup({
	labels = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()_+",
	search = {
		-- search/jump in all windows
		multi_window = true,
		-- search direction
		forward = false,
		-- when `false`, find only matches in the given direction
		wrap = true,
		-- Each mode will take ignorecase and smartcase into account.
		-- * exact: exact match
		-- * search: regular search
		-- * fuzzy: fuzzy search
		mode = "exact",
		-- behave like `incsearch`
		incremental = false,
		-- Excluded filetypes and custom window filters
		exclude = {
			"notify",
			"cmp_menu",
			"snacks_picker_list",
			"flash_prompt",
			function(win)
				-- exclude non-focusable windows
				return not vim.api.nvim_win_get_config(win).focusable
			end,
		},
		-- Optional trigger character that needs to be typed before
		-- a jump label can be used. It's NOT recommended to set this,
		-- unless you know what you're doing
		trigger = "",
		-- max pattern length. If the pattern length is equal to this
		-- labels will no longer be skipped. When it exceeds this length
		-- it will either end in a jump or terminate the search
		max_length = nil, ---@type number?
	},
	jump = {
		-- save location in the jumplist
		jumplist = true,
		-- jump position
		pos = "start", ---@type "start" | "end" | "range"
		-- add pattern to search history
		history = false,
		-- add pattern to search register
		register = false,
		-- clear highlight after jump
		nohlsearch = true,
		-- automatically jump when there is only one match
		autojump = false,
		-- You can force inclusive/exclusive jumps by setting the
		-- `inclusive` option. By default it will be automatically
		-- set based on the mode.
		inclusive = nil, ---@type boolean?
		-- jump position offset. Not used for range jumps.
		-- 0: default
		-- 1: when pos == "end" and pos < current position
		offset = nil, ---@type number
	},
	label = {
		-- allow uppercase labels
		-- add any labels with the correct case here, that you want to exclude
		exclude = "",
		uppercase = true,
		-- add a label for the first match in the current window.
		-- you can always jump to the first match with `<CR>`
		current = true,
		-- show the label after the match
		after = { 0, 0 }, ---@type boolean|number[]
		-- show the label before the match
		before = false, ---@type boolean|number[]
		-- position of the label extmark
		style = "overlay", ---@type "eol" | "overlay" | "right_align" | "inline"
		-- flash tries to re-use labels that were already assigned to a position,
		-- when typing more characters. By default only lower-case labels are re-used.
		reuse = "all", ---@type "lowercase" | "all"
		-- for the current window, label targets closer to the cursor first
		distance = true,
		-- minimum pattern length to show labels
		-- Ignored for custom labelers.
		min_pattern_length = 0,
		-- Enable this to use rainbow colors to highlight labels
		-- Can be useful for visualizing Treesitter ranges.
		rainbow = {
			enabled = false,
			-- number between 1 and 9
			shade = 5,
		},
		format = function(opts)
			return { { opts.match.label, opts.hl_group } }
		end,
	},
	highlight = {
		-- show a backdrop with hl FlashBackdrop
		backdrop = true,
		-- Highlight the search matches
		matches = true,
		-- extmark priority
		priority = 5000,
		groups = {
			match = "FlashMatch",
			current = "FlashCurrent",
			backdrop = "FlashBackdrop",
			label = "FlashLabel",
		},
	},
	-- initial pattern to use when opening flash
	pattern = "",
	-- When `true`, flash will try to continue the last search
	continue = true,
	modes = {
		-- options used when flash is activated through
		-- a regular search with `/` or `?`
		search = {
			enabled = false, -- enable flash for search
			highlight = { backdrop = false },
			jump = { history = true, register = true, nohlsearch = true },
			search = {
				-- `forward` will be automatically set to the search direction
				-- `mode` is always set to `search`
				-- `incremental` is set to `true` when `incsearch` is enabled
			},
		},
		-- options used when flash is activated through
		-- `f`, `F`, `t`, `T`, `;` and `,` motions
		char = {
			enabled = false,
			-- dynamic configuration for ftFT motions
			config = function(opts)
				-- autohide flash when in operator-pending mode
				opts.autohide = vim.fn.mode(true):find("no") and vim.v.operator == "y"

				-- disable jump labels when enabled and when using a count
				opts.jump_labels = opts.jump_labels and vim.v.count == 0

				-- Show jump labels only in operator-pending mode
				-- opts.jump_labels = vim.v.count == 0 and vim.fn.mode(true):find("o")
			end,
			-- hide after jump when not using jump labels
			autohide = false,
			-- show jump labels
			jump_labels = false,
			-- set to `false` to use the current line only
			multi_line = true,
			-- When using jump labels, don't use these keys
			-- This allows using those keys directly after the motion
			label = { exclude = "hjkliardc" },
			-- by default all keymaps are enabled, but you can disable some of them,
			-- by removing them from the list.
			-- If you rather use another key, you can map them
			-- to something else, e.g., { [";"] = "L", [","] = H }
			keys = { "f", "F", "t", "T", ";", "," },
			---@alias Flash.CharActions table<string, "next" | "prev" | "right" | "left">
			-- The direction for `prev` and `next` is determined by the motion.
			-- `left` and `right` are always left and right.
			char_actions = function(motion)
				return {
					[";"] = "next", -- set to `right` to always go right
					[","] = "prev", -- set to `left` to always go left
					-- clever-f style
					[motion:lower()] = "next",
					[motion:upper()] = "prev",
					-- jump2d style: same case goes next, opposite case goes prev
					-- [motion] = "next",
					-- [motion:match("%l") and motion:upper() or motion:lower()] = "prev",
				}
			end,
			search = { wrap = false },
			highlight = { backdrop = true },
			jump = { register = false },
		},
		-- options used for treesitter selections
		-- `require("flash").treesitter()`
		treesitter = {
			labels = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()_+",
			jump = { pos = "range" },
			search = { incremental = false },
			label = { before = true, after = true, style = "inline" },
			highlight = {
				backdrop = true,
				matches = false,
			},
		},
		treesitter_search = {
			jump = { pos = "range" },
			search = { multi_window = true, wrap = true, incremental = false },
			remote_op = { restore = true },
			label = { before = true, after = true, style = "inline" },
		},
	},
	-- options for the floating window that shows the prompt,
	-- for regular jumps
	prompt = {
		enabled = true,
		prefix = { { "⚡ Jump to : ", "FlashPromptIcon" } },
		win_config = {
			relative = "editor",
			width = 1,
			height = 1,
			row = -1,
			col = 0,
			zindex = 1000,
		},
	},
})
