local status_ok, gitlog = pcall(require, "git-log")
if not status_ok then
	print("Error: git-log")
	return
end

gitlog.setup({
	-- args of git log
	extra_args = {},
	-- window options
	win = {
		border = "rounded",
		width_ratio = 0.75,
		height_ratio = 0.6,
	},
	keymap = {
		-- keymap to close the window
		close = "q",
	},
})
