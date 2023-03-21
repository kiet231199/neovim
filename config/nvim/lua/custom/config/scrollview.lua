local status_ok, scrollview = pcall(require, "scrollview")
if not status_ok then
	print("Error: scrollview")
	return
end

scrollview.setup({
	character = '█',
	modes = 'simple',
	zindex = 5,
	winblend = 50,
	base = 'right',
	column = 1,
	current_only = true,
	hide_on_intersect = false,
})
