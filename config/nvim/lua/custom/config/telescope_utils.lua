local action_set = require "telescope.actions.set"
local action_state = require "telescope.actions.state"
local state = require "telescope.state"

local scroll_previewer = function(prompt_bufnr, direction)
	local previewer = action_state.get_current_picker(prompt_bufnr).previewer
	local status = state.get_status(prompt_bufnr)

	-- Check if we actually have a previewer and a preview window
	if type(previewer) ~= "table" or previewer.scroll_fn == nil or status.preview_win == nil then
		return
	end

	local default_speed = vim.api.nvim_win_get_height(status.preview_win) / 2
	local speed = status.picker.layout_config.scroll_speed or default_speed

	previewer:scroll_fn(math.floor(speed * direction))
end

local utils = function(prompt_bufnr)
	scroll_previewer(prompt_bufnr, 1)
end

return utils
