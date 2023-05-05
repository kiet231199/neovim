local status_ok, muren = pcall(require, "muren")
if not status_ok then
	print("Error: muren")
	return
end

muren.setup({
	-- general
	create_commands = true,
	-- default togglable options
	two_step = false,
	all_on_line = true,
	preview = true,
	-- keymaps
	keys = {
		close = 'q',
		toggle_side = '<Tab>',
		toggle_options_focus = '<S-Tab>',
		toggle_option_under_cursor = '<CR>',
		do_replace = '<CR>',
	},
	-- ui sizes
	patterns_width = 30,
	patterns_height = 10,
	options_width = 15,
	preview_height = 12,
	-- options order in ui
	order = {
		'buffer',
		'two_step',
		'all_on_line',
		'preview',
	},
	-- highlights used for options ui
	hl = {
		options = {
			on = '@string',
			off = '@variable.builtin',
		},
	},
})

