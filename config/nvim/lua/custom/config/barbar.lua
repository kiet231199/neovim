local status_ok, barbar = pcall(require, "barbar")
if not status_ok then
	print("Error: barbar")
	return
end

vim.g.barbar_auto_setup = false -- disable auto-setup

barbar.setup({
	animation = true,
	auto_hide = false,
	tabpages = false,
	clickable = true,
	exclude_ft = { '' },
	exclude_name = { '' },
	focus_on_close = 'left',
	-- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.
	hide = { extensions = false, inactive = false, alternate = true },
	-- Disable highlighting alternate buffers
	highlight_alternate = false,
	-- Disable highlighting file icons in inactive buffers
	highlight_inactive_file_icons = false,
	-- Enable highlighting visible buffers
	highlight_visible = true,
	icons = {
		-- Configure the base icons on the bufferline.
		-- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
		buffer_index = true,
		buffer_number = false,
		button = '',
		diagnostics = {
			[vim.diagnostic.severity.ERROR] = { enabled = true, icon = ' ' },
			[vim.diagnostic.severity.WARN] = { enabled = true, icon = ' ' },
			[vim.diagnostic.severity.INFO] = { enabled = true, icon = '' },
			[vim.diagnostic.severity.HINT] = { enabled = true, icon = '' },
		},
		gitsigns = {
			added = { enabled = true, icon = '' },
			changed = { enabled = true, icon = '' },
			deleted = { enabled = true, icon = '' },
		},
		filetype = {
			-- Sets the icon's highlight group.
			-- If false, will use nvim-web-devicons colors
			custom_colors = true,
			enabled = true,
		},
		separator = { left = '', right = '' },
		-- If true, add an additional separator at the end of the buffer list
		separator_at_end = false,
		-- Configure the icons on the bufferline when modified or pinned.
		-- Supports all the base icon options.
		modified = { button = '' },
		pinned = { button = '', filename = true },
		-- Use a preconfigured buffer appearance— can be 'default', 'powerline', or 'slanted'
		preset = 'powerline',
		-- Configure the icons on the bufferline based on the visibility of a buffer.
		-- Supports all the base icon options, plus `modified` and `pinned`.
		alternate = { filetype = { enabled = false } },
		current = { buffer_index = true },
		inactive = { button = '' },
		visible = { modified = { buffer_number = false } },
	},
	-- If true, new buffers will be inserted at the start/end of the list.
	-- Default is to insert after current buffer.
	insert_at_end = true,
	insert_at_start = false,
	-- Sets the maximum padding width with which to surround each tab
	maximum_padding = 1,
	-- Sets the minimum padding width with which to surround each tab
	minimum_padding = 1,
	-- Sets the maximum buffer name length.
	maximum_length = 40,
	-- Sets the minimum buffer name length.
	minimum_length = 10,
	semantic_letters = true,
	-- Set the filetypes which barbar will offset itself for
	sidebar_filetypes = {
		['neo-tree'] = { event = 'BufWipeout' },
		['lspsagaoutline'] = { event = 'BufWinLeave', text = 'symbols-outline' },
	},
	-- New buffer letters are assigned in this order. This order is
	-- optimal for the qwerty keyboard layout but might need adjustment
	-- for other layouts.
	letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
	-- Sets the name of unnamed buffers. By default format is "[Buffer X]"
	-- where X is the buffer number. But only a static string is accepted here.
	no_name_title = nil,
})

vim.api.nvim_set_hl(0, "BufferCurrent", { fg = "Black", bg = "#7aa2f7" })
vim.api.nvim_set_hl(0, "BufferCurrentMod", { fg = "Black", bg = "#7aa2f7" })
vim.api.nvim_set_hl(0, "BufferCurrentIcon", { fg = "Black", bg = "#7aa2f7" })
vim.api.nvim_set_hl(0, "BufferCurrentIndex", { fg = "Black", bg = "#7aa2f7" })
vim.api.nvim_set_hl(0, "BufferCurrentSign", { fg = "#7aa2f7", bg = "#262a3c" })
vim.api.nvim_set_hl(0, "BufferCurrentSignRight", { fg = "#7aa2f7", bg = "#262a3c" })
vim.api.nvim_set_hl(0, "BufferCurrentADDED", { fg = "#7aa2f7", bg = "Green" })
vim.api.nvim_set_hl(0, "BufferCurrentCHANGED", { fg = "#7aa2f7", bg = "Yellow" })
vim.api.nvim_set_hl(0, "BufferCurrentDELETED", { fg = "#7aa2f7", bg = "Red" })
vim.api.nvim_set_hl(0, "BufferCurrentERROR", { fg = "#7aa2f7", bg = "#db4b4b" })
vim.api.nvim_set_hl(0, "BufferCurrentWARN", { fg = "#7aa2f7", bg = "#e0af68" })
vim.api.nvim_set_hl(0, "BufferCurrentHINT", { fg = "#7aa2f7", bg = "#1abc9c" })
vim.api.nvim_set_hl(0, "BufferCurrentINFO", { fg = "#7aa2f7", bg = "#0db9d7" })

vim.api.nvim_set_hl(0, "BufferVisible", { fg = "Black", bg = "#3b4261" })
vim.api.nvim_set_hl(0, "BufferVisibleMod", { fg = "Black", bg = "#3b4261" })
vim.api.nvim_set_hl(0, "BufferVisibleIcon", { fg = "Black", bg = "#3b4261" })
vim.api.nvim_set_hl(0, "BufferVisibleIndex", { fg = "Black", bg = "#3b4261" })
vim.api.nvim_set_hl(0, "BufferVisibleSign", { fg = "#3b4261", bg = "#262a3c" })
vim.api.nvim_set_hl(0, "BufferVisibleSignRight", { fg = "#3b4261", bg = "#262a3c" })
vim.api.nvim_set_hl(0, "BufferVisibleADDED", { fg = "#3b4261", bg = "Green" })
vim.api.nvim_set_hl(0, "BufferVisibleCHANGED", { fg = "#3b4261", bg = "Yellow" })
vim.api.nvim_set_hl(0, "BufferVisibleDELETED", { fg = "#3b4261", bg = "Red" })
vim.api.nvim_set_hl(0, "BufferVisibleERROR", { fg = "#3b4261", bg = "#db4b4b" })
vim.api.nvim_set_hl(0, "BufferVisibleWARN", { fg = "#3b4261", bg = "#e0af68" })
vim.api.nvim_set_hl(0, "BufferVisibleHINT", { fg = "#3b4261", bg = "#1abc9c" })
vim.api.nvim_set_hl(0, "BufferVisibleINFO", { fg = "#3b4261", bg = "#0db9d7" })
