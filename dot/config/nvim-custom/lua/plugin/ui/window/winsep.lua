local status_ok, winsep = pcall(require, "colorful-winsep")
if not status_ok then
	print("Error: colorful-winsep")
	return
end

winsep.setup({
	-- Window divider color definition
	highlight = {
		bg = "#1A1B26",
		fg = "#A9B1D6"
	},
	-- filetype in the list, will not be executed
	no_exec_files = { "lazy", "TelescopePrompt", "mason", "CompetiTest", "neotree" },
	-- Split line symbol definition
	symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
	only_line_seq = true,
	smooth = true,
	exponential_smoothing = true,
	anchor = {
		left   = { height = 1, x = -1, y = -1 },
		right  = { height = 1, x = -1, y = 0 },
		up     = { width  = 0, x = -1, y = 0 },
		bottom = { width  = 0, x = 1,  y = 0 },
	},
})
