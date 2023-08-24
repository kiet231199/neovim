local status_ok, cokeline = pcall(require, "cokeline")
if not status_ok then
	print("Error: cokeline")
	return
end

local get_hex = require('cokeline/utils').get_hex

local my_color = {
    focus = {
        fg = "#15161e",
        bg = "#7aa2f7",
    },
    non_focus = {
        fg = "#5c87eb",
        bg = "#3b4261",
    },
}

cokeline.setup({
	show_if_buffers_are_at_least = 1,
	buffers = {
		focus_on_delete = 'next',
		new_buffers_position = 'last',
		delete_on_right_click = true,
	},
	rendering = {
		max_buffer_width = 60,
	},

	default_hl = {
		fg = function(buffer)
			return
				buffer.is_focused
				and my_color.focus.fg
				or my_color.non_focus.fg
		end,
		bg = function(buffer)
			return
				buffer.is_focused
				and my_color.focus.bg
				or my_color.non_focus.bg
		end,
	},

	components = {
		{
			text = '',
            fg = function(buffer)
                return
                    buffer.is_focused
                    and my_color.focus.bg
                    or my_color.non_focus.bg
            end,
            bg = get_hex('Normal', 'bg'),
		},
		{
			text = ' ',
		},
		{
			text = function(buffer)
				return buffer.devicon.icon
			end,
			fg = function(buffer)
                if buffer.is_focused then
                    return my_color.focus.fg
                else
                    return buffer.devicon.color
                end
			end,
		},
		{
			text = ' ',
		},
        {
            text = function(buffer) return buffer.index .. ':' end,
			style = function(buffer)
				return buffer.is_focused and 'bold' or nil
			end,
        },
		{
			text = function(buffer) return buffer.filename .. ' ' end,
			style = function(buffer)
				return buffer.is_focused and 'bold' or nil
			end,
		},
		{
			text = function(buffer)
                if buffer.is_focused then
                    if buffer.diagnostics.errors ~= 0 then
                        return ":" .. buffer.diagnostics.errors
                    else
                        if buffer.diagnostics.warnings ~= 0 then
                            return ":" .. buffer.diagnostics.warnings
                        else
                            return ''
                        end
                    end
                else
                    return ''
                end
			end,
            style = 'bold',
			fg = function(buffer)
                if buffer.diagnostics.errors ~= 0 then
                    return get_hex('DiagnosticError', 'fg')
                else
                    if buffer.diagnostics.warnings ~=0 then
                        return get_hex('DiagnosticWarning', 'fg')
                    else
                        return my_color.focus.fg
                    end
                end
			end,
		},
		{
			text = ' ',
		},
		{
			text = '',
			delete_buffer_on_left_click = true,
		},
		{
			text = ' ',
		},
		{
			text = '',
            fg = function(buffer)
                return
                    buffer.is_focused
                    and my_color.focus.bg
                    or my_color.non_focus.bg
            end,
            bg = get_hex('Normal', 'bg'),
		},
		{
			text = ' ',
			fg = get_hex('Normal', 'fg'),
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
	tabs = {
		placement = "right",
		components = {
            {
                text = '',
                fg = my_color.focus.bg,
                bg = get_hex('Normal', 'bg'),
            },
            {
                text = function(buffer)
                    return ' 󰃰 ' .. vim.fn.strftime('%H:%M - %a, %d/%m/%Y') .. ' '
                end,
                style = 'bold',
                fg = my_color.focus.fg,
                bg = my_color.focus.bg,
            },
            {
                text = '',
                fg = my_color.focus.bg,
                bg = get_hex('Normal', 'bg'),
            },
        },
    },
})
