local status_ok, searchbox = pcall(require, "searchbox")
if not status_ok then
	print("Error: searchbox")
	return
end

searchbox.setup({
	defaults = {
		reverse = false,
		exact = true,
		prompt = '🔍 ',
		modifier = 'disabled',
		confirm = 'yes',
		clear_matches = true,
		show_matches = false,
	},
	popup = {
		relative = 'cursor',
		position = {
			row = 2,
			col = 0,
		},
    	size = 30,
		border = {
			style = 'rounded',
			text = {
				top = ' Search ',
				top_align = 'left',
			},
		},
		win_options = {
			winhighlight = 'Normal:Normal,FloatBorder:Normal',
		},
	},
})

