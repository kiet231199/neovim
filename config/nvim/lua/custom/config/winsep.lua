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
	-- timer refresh rate
	interval = 300,
	-- filetype in the list, will not be executed
	no_exec_files = { "lazy", "TelescopePrompt", "mason", "CompetiTest", "NvimTree" },
	-- Split line symbol definition
	symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
	close_event = function()
		-- Executed after closing the window divider
	end,
	create_event = function()
		-- local win_n = require("colorful-winsep.utils").calculate_number_windows()
		-- if win_n == 2 then
		-- 	local win_id = vim.fn.win_getid(vim.fn.winnr('h'))
		-- 	local filetype = vim.api.nvim_get_option_value('filetype', { buf = vim.api.nvim_win_get_buf(win_id) })
		-- 	if filetype == "neo-tree" then
		-- 		winsep.NvimSeparatorDel()
		-- 	end
		-- end
	end
})
