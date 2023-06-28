local action_state = require "telescope.actions.state"
local state = require "telescope.state"

local scroll_previewer_one = function(prompt_bufnr, direction)
	local previewer = action_state.get_current_picker(prompt_bufnr).previewer
	local status = state.get_status(prompt_bufnr)

	-- Check if we actually have a previewer and a preview window
	if type(previewer) ~= "table" or previewer.scroll_fn == nil or previewer.scroll_horizontal_fn == nil or status.preview_win == nil then
		return
	end

	if direction == 1 then previewer:scroll_fn(math.floor(-1)) end               -- Up
	if direction == 2 then previewer:scroll_fn(math.floor(1)) end                -- Down
	if direction == 3 then previewer:scroll_horizontal_fn(math.floor(1)) end     -- Left
	if direction == 4 then previewer:scroll_horizontal_fn(math.floor(-1)) end    -- Right

	return true
end

scroll_timer = vim.loop.new_timer()
local scroll_previewer = function(prompt_bufnr, direction, time, lines)
	local scroll_time = time / 100
	local time_step = math.floor(time / (lines - 1) + 0.5)
	local next_time_step = math.floor(time / (lines - 2) + 0.5)
	local next_next_time_step = math.floor(time / (lines - 3) + 0.5)

	local lines_to_scroll = lines
	-- Scroll the first line

	-- Callback function triggered by scroll_timer
	local function scroll_callback()
		if math.abs(lines_to_scroll) > 2 then
			next_time_step = math.floor(scroll_time + 0.5)
			-- sets the repeat of the next cycle
			scroll_timer:set_repeat(next_time_step)
		end
		if math.abs(lines_to_scroll) == 0 then
			scroll_timer:stop()
			return
		end
		scroll_previewer_one(prompt_bufnr, direction)
		lines_to_scroll = lines_to_scroll - 1
	end

	-- Start timer to scroll the rest of the lines
	scroll_timer:start(time_step, next_time_step, vim.schedule_wrap(scroll_callback))
	scroll_timer:set_repeat(next_next_time_step)
end

local utils = {
	scroll_up    = function(prompt_bufnr) scroll_previewer(prompt_bufnr, 1, 400, 10) end,
	scroll_down  = function(prompt_bufnr) scroll_previewer(prompt_bufnr, 2, 400, 10) end,
	scroll_left  = function(prompt_bufnr) scroll_previewer(prompt_bufnr, 3, 600, 20) end,
	scroll_right = function(prompt_bufnr) scroll_previewer(prompt_bufnr, 4, 600, 20) end,
}

return utils
