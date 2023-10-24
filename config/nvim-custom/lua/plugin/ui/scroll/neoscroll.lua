local status_ok, neoscroll = pcall(require, "neoscroll")
if not status_ok then
	print("Error: neoscroll")
	return
end

neoscroll.setup({
    -- All these keys will be mapped to their corresponding default scrolling animation
    hide_cursor = false,			-- Hide cursor while scrolling
    stop_eof = true,				-- Stop at <EOF> when scrolling downwards
    respect_scrolloff = true,		-- Stop scrolling when the cursor reaches the scrolloff margin of the file
    cursor_scrolls_alone = true,	-- The cursor will keep on scrolling even if the window cannot scroll further
    performance_mode = false,		-- Disable "Performance Mode" on all buffers.
})

local t = {}
-- Syntax: t[keys] = {function, {function arguments}}
t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '400', [['cubic']]}}
t['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '400', [['cubic']]}}

-- Use the "cubic" cubic function
t['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '800', [['cubic']]}}
t['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '800', [['cubic']]}}

-- Pass "cubic" to disable the cubic animation (constant scrolling speed)
t['<C-y>'] = {'scroll', {'-0.1', 'false', '50', [['cubic']]}}
t['<C-e>'] = {'scroll', { '0.1', 'false', '50', [['cubic']]}}

t['<ScrollWheelUp>'] = {'scroll', {'-0.2', 'true', '200', [['cubic']]}}
t['<ScrollWheelDown>'] = {'scroll', { '0.2', 'true', '200', [['cubic']]}}

-- When no easing function is provided the default easing function (in this case "quadratic") will be used
t['zt']    = {'zt', {'300'}}
t['zz']    = {'zz', {'300'}}
t['zb']    = {'zb', {'300'}}

require('neoscroll.config').set_mappings(t)
