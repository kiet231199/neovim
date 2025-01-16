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
	level = vim.log.levels.TRACE,
	minimum_width = 30,
	render = "default",
	stages = "fade",
	timeout = 3000
})
