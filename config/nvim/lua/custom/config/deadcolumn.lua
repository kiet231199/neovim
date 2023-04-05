local status_ok, deadcolumn = pcall(require, "deadcolumn")
if not status_ok then
	print("Error: deadcolumn")
	return
end

deadcolumn.setup({
	scope = 'line',
	blending = {
		threshold = 0.75,
		colorcode = '#000000',
		hlgroup = {
			'Normal',
			'background',
		},
	},
	warning = {
		alpha = 0.4,
		colorcode = '#000000',
		hlgroup = {
			'None',
			'foreground',
		},
	},
})

