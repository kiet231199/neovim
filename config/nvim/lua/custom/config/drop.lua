local status_ok, drop = pcall(require, "drop")
if not status_ok then
	print("Error: drop")
	return
end

drop.setup({
	---@type DropTheme|string
	theme = "stars", -- can be one of the default themes, or a custom theme
	max = 30, -- maximum number of drops on the screen
	interval = 200, -- every 150ms we update the drops
	screensaver = 1000 * 60 * 5, -- show after 5 minutes. Set to false, to disable
	filetypes = { "dashboard", "alpha", "starter" }, -- will enable/disable automatically for the following filetypes
})

