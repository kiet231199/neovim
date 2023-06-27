local action_state = require "telescope.actions.state"
local state = require "telescope.state"

local scroll_previewer_oneline = function(prompt_bufnr, direction)
	local previewer = action_state.get_current_picker(prompt_bufnr).previewer
	local status = state.get_status(prompt_bufnr)

	-- Check if we actually have a previewer and a preview window
	if type(previewer) ~= "table" or previewer.scroll_fn == nil or status.preview_win == nil then
		return
	end

	-- local default_speed = vim.api.nvim_win_get_height(status.preview_win) / 2
	-- local speed = status.picker.layout_config.scroll_speed or default_speed

	-- previewer:scroll_fn(math.floor(speed * direction))
	previewer:scroll_fn(math.floor(1 * direction))
	return true
end

local scroll_timer = vim.loop.new_timer()
local scroll_previewer = function(prompt_bufnr, direction, time, lines)
	local time_step = math.floor(time / (lines - 1) + 0.5)
	local next_time_step = math.floor(time / (lines - 2) + 0.5)
	local next_next_time_step = math.floor(time / (lines - 3) + 0.5)

	local lines_to_scroll = lines
	-- Scroll the first line

	-- Callback function triggered by scroll_timer
	local function scroll_callback()
		if math.abs(lines_to_scroll) > 2 then
			local next_lines_to_scroll = math.abs(lines_to_scroll) - 2
			next_time_step = ath.floor(time / (lines - 1) + 0.5)
			compute_time_step(next_lines_to_scroll, lines, time, ef)
			-- sets the repeat of the next cycle
			scroll_timer:set_repeat(next_time_step)
		end
		if math.abs(lines_to_scroll) == 0 then
			stop_scrolling(move_cursor, info)
			return
		end
		scroll_previewer_oneline(prompt_bufnr, direction)
		lines_to_scroll -= 1
		if math.abs(lines_to_scroll) == 1 then
			stop_scrolling(move_cursor, info)
			return
		end
	end

	-- Start timer to scroll the rest of the lines
	scroll_timer:start(time_step, next_time_step, vim.schedule_wrap(scroll_callback))
	scroll_timer:set_repeat(next_next_time_step)
end

local utils = {
	scroll = function(prompt_bufnr)

	end
}

return utils
