local status_ok, smoothcursor = pcall(require, "smoothcursor")
if not status_ok then
	print("Error: smoothcursor")
	return
end

-- Disable when enter command
vim.api.nvim_create_autocmd("CmdlineEnter", { command = ":SmoothCursorStop", })
vim.api.nvim_create_autocmd("CmdlineLeave", { command = ":SmoothCursorStart", })

-- Disable when enter floaterm
vim.api.nvim_create_autocmd("TermOpen", { command = ":SmoothCursorStop", })
vim.api.nvim_create_autocmd("TermClose", { command = ":SmoothCursorStart", })

smoothcursor.setup({
	autostart = true,
	cursor = "▷",             -- cursor shape (need nerd font)
	texthl = "SmoothCursor",  -- highlight group, default is { bg = nil, fg = "#FFD400" }
	linehl = nil,             -- highlight sub-cursor line like 'cursorline', "CursorLine" recommended
	type = "default",         -- define cursor movement calculate function, "default" or "exp" (exponential).
	fancy = {
		enable = true,       -- enable fancy mode
		head = { cursor = "󰆿", texthl = "SmoothCursor", linehl = nil },
		body = {
			{ cursor = "", texthl = "SmoothCursorRed" },
			{ cursor = "", texthl = "SmoothCursorOrange" },
			{ cursor = "󰝦", texthl = "SmoothCursorYellow" },
			{ cursor = "󰝦", texthl = "SmoothCursorGreen" },
			{ cursor = "•", texthl = "SmoothCursorAqua" },
			{ cursor = ".", texthl = "SmoothCursorBlue" },
			{ cursor = ".", texthl = "SmoothCursorPurple" },
		},
		tail = { cursor = nil, texthl = "SmoothCursor" }
	},
	speed = 25,               -- max is 100 to stick to your current position
	flyin_effect = nil,       -- Choose "bottom" or "top" for flying effecthh
	intervals = 35,           -- tick interval
	priority = 10,            -- set marker priority
	timeout = 3000,           -- timout for animation
	threshold = 3,            -- animate if threshold lines jump
	disable_float_win = true, -- Disable in floating windows
	enabled_filetypes = nil,  -- example: { "lua", "vim" }
	disabled_filetypes = { "dropbar_menu" }, -- this option will be skipped if enabled_filetypes is set. example: { "TelescopePrompt", "NvimTree" }
})
