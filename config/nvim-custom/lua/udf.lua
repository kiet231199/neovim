-- User define functions

function ToggleCopyMode()
	if vim.o.number == true then
		vim.o.signcolumn = "no"
		vim.o.number = false
		vim.o.relativenumber = false
		-- vim.o.mouse = ""
		vim.cmd("IBLToggle")
		vim.cmd("ScrollViewDisable")
	else
		vim.o.signcolumn = "yes"
		vim.o.number = true
		vim.o.relativenumber = true
		-- vim.o.mouse = "a"
		vim.cmd("IBLToggle")
		vim.cmd("ScrollViewEnable")
	end
end

function ToggleGlobalStatusLine()
	if vim.o.laststatus == 3 then
		vim.o.laststatus = 2
	else
		vim.o.laststatus = 3
	end
end

function ToggleBackground()
	require("plugin.colorscheme").toggle_background()
end

function ToggleLSP()
	if vim.diagnostic.is_disabled() then
		vim.diagnostic.enable()
	else
		vim.diagnostic.disable()
	end
end
