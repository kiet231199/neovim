local status_ok, notify = pcall(require, "notify")
if not status_ok then
	print("Error: notify")
	return
end

notify.setup({
	background_colour = "Normal",
	fps = 20,
	icons = {
		DEBUG = " ",
		ERROR = " ",
		INFO = " ",
		TRACE = "✎",
		WARN = " "
	},
	level = 2,
	minimum_width = 30,
	render = "wrapped-compact",
	stages = "fade",
	timeout = 3000
})
