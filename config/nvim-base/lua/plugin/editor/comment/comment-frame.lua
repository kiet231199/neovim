local status_ok, commentframe = pcall(require, "nvim-comment-frame")
if not status_ok then
	print("Error: nvim-comment-frame")
	return
end

commentframe.setup({
	disable_default_keymap = false,
	-- adds custom keymap
	keymap = 'gl',
	multiline_keymap = 'gm',
	-- start the comment with this string
	start_str = '#',
	-- end the comment line with this string
	end_str = '#',
	-- fill the comment frame border with this character
	fill_char = '#',
	-- width of the comment frame
	frame_width = 70,
	-- wrap the line after 'n' characters
	line_wrap_len = 50,
	-- automatically indent the comment frame based on the line
	auto_indent = true,
	-- add comment above the current line
	add_comment_above = true,
	languages = {
		lua = {
			start_str = '--',
			end_str = '--',
			fill_char = '-',
			frame_width = 100,
			line_wrap_len = 70,
			auto_indent = true,
			add_comment_above = true,
		},
		bash = {
			start_str = '#',
			end_str = '#',
			fill_char = '#',
			frame_width = 80,
			line_wrap_len = 70,
			auto_indent = true,
			add_comment_above = true,
		},
		python = {
			start_str = '#',
			end_str = '#',
			fill_char = '#',
			frame_width = 80,
			line_wrap_len = 70,
			auto_indent = true,
			add_comment_above = true,
		},
		c = {
			start_str = '/*',
			end_str = '*/',
			fill_char = '*',
			frame_width = 80,
			line_wrap_len = 70,
			auto_indent = true,
			add_comment_above = true,
		},
		cpp = {
			start_str = '/*',
			end_str = '*/',
			fill_char = '*',
			frame_width = 80,
			line_wrap_len = 70,
			auto_indent = true,
			add_comment_above = true,
		},
	}
})
