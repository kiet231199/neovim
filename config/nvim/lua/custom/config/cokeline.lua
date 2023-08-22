local status_ok, cokeline = pcall(require, "cokeline")
if not status_ok then
	print("Error: cokeline")
	return
end

local get_hex = require('cokeline/utils').get_hex

cokeline.setup({
	show_if_buffers_are_at_least = 1,
	buffers = {
	  -- A function to filter out unwanted buffers. Takes a buffer table as a
	  -- parameter (see the following section for more infos) and has to return
	  -- either `true` or `false`.
	  -- default: `false`.
	  filter_valid = function(buffer) -> true | false,

	  -- A looser version of `filter_valid`, use this function if you still
	  -- want the `cokeline-{switch,focus}-{prev,next}` mappings to work for
	  -- these buffers without displaying them in your bufferline.
	  -- default: `false`.
	  filter_visible = function(buffer) -> true | false,

	  -- Which buffer to focus when a buffer is deleted, `prev` focuses the
	  -- buffer to the left of the deleted one while `next` focuses the one the
	  -- right.
	  -- default: 'next'.
	  focus_on_delete = 'next',

	  -- If set to `last` new buffers are added to the end of the bufferline,
	  -- if `next` they are added next to the current buffer.
	  -- if set to `directory` buffers are sorted by their full path.
	  -- if set to `number` buffers are sorted by bufnr, as in default Neovim
	  -- default: 'last'.
	  new_buffers_position = 'last' | 'next' | 'directory' | 'number' | function(buffer_a, buffer_b) -> true | false,

	  -- If true, right clicking a buffer will close it
	  -- The close button will still work normally
	  -- Default: true
	  delete_on_right_click = true | false,
	},
	rendering = {
	  max_buffer_width = 60,
	},

	default_hl = {
		fg = function(buffer)
			return
				buffer.is_focused
				and get_hex('Normal', 'fg')
				or get_hex('Comment', 'fg')
		end,
		bg = get_hex('ColorColumn', 'bg'),
	},

	components = {
		{
			text = ' ',
			bg = get_hex('Normal', 'bg'),
		},
		{
			text = '',
			fg = get_hex('ColorColumn', 'bg'),
			bg = get_hex('Normal', 'bg'),
		},
		{
			text = function(buffer)
				return buffer.devicon.icon
			end,
			fg = function(buffer)
				return buffer.devicon.color
			end,
		},
		{
			text = ' ',
		},
		{
			text = function(buffer) return buffer.filename .. '  ' end,
			style = function(buffer)
				return buffer.is_focused and 'bold' or nil
			end,
		},
		{
			text = '',
			delete_buffer_on_left_click = true,
		},
		{
			text = '',
			fg = get_hex('ColorColumn', 'bg'),
			bg = get_hex('Normal', 'bg'),
		},
	},

	-- Custom areas can be displayed on the right hand side of the bufferline.
	-- They act identically to buffer components, except their methods don't take a Buffer object.
	-- If you want a rhs component to be stateful, you can wrap it in a closure containing state.
	-- rhs = {},

	-- Tabpages can be displayed on either the left or right of the bufferline.
	-- They act the same as other components, except they are passed TabPage objects instead of
	-- buffer objects.
	-- tabs = {
	-- 	placement = "left" | "right",
	-- 	components = {},
	-- },
})
