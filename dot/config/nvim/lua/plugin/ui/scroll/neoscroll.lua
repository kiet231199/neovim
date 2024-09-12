local status_ok, neoscroll = pcall(require, "neoscroll")
if not status_ok then
	print("Error: neoscroll")
	return
end

neoscroll.setup({
	mappings = {},
	hide_cursor = false,       -- Hide cursor while scrolling
	stop_eof = true,           -- Stop at <EOF> when scrolling downwards
	respect_scrolloff = true,  -- Stop scrolling when the cursor reaches the scrolloff margin of the file
	cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
	easing = 'linear',         -- Default easing function
	pre_hook = nil,            -- Function to run before the scrolling animation starts
	post_hook = nil,           -- Function to run after the scrolling animation ends
	performance_mode = false,  -- Disable "Performance Mode" on all buffers.
	ignored_events = {         -- Events ignored while scrolling
		'WinScrolled', 'CursorMoved'
	},
})

local keymap = {
	-- Use the "cubic" cubic function
	["<C-u>"]             = function() neoscroll.ctrl_u({ duration = 400, easing = "cubic" }) end,
	["<C-d>"]             = function() neoscroll.ctrl_d({ duration = 400, easing = "cubic" }) end,
	["<C-b>"]             = function() neoscroll.ctrl_b({ duration = 800, easing = "cubic" }) end,
	["<C-f>"]             = function() neoscroll.ctrl_f({ duration = 800, easing = "cubic" }) end,
	["<C-y>"]             = function() neoscroll.scroll(-0.1, { move_cursor = false, duration = 50, easing = "cubic" }) end,
	["<C-e>"]             = function() neoscroll.scroll( 0.1, { move_cursor = false, duration = 50, easing = "cubic" } ) end,
	["<ScrollWheelUp>"]   = function() neoscroll.scroll(-0.2, { move_cursor = true, duration = 50, easing = "cubic" }) end,
	["<ScrollWheelDown>"] = function() neoscroll.scroll( 0.2, { move_cursor = true, duration = 50, easing = "cubic" } ) end,
	["zt"]                = function() neoscroll.zt({ half_win_duration = 300 }) end,
	["zz"]                = function() neoscroll.zz({ half_win_duration = 300 }) end,
	["zb"]                = function() neoscroll.zb({ half_win_duration = 300 }) end,
}

local modes = { 'n', 'v', 'x' }
for key, func in pairs(keymap) do
	vim.keymap.set(modes, key, func)
end
