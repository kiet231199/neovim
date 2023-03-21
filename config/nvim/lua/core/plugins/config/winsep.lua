local status_ok, winsep = pcall(require, "colorful-winsep")
if not status_ok then
	print("Error: colorful-winsep")
	return
end

winsep.setup({
	-- Window divider color definition
	highlight = {
		guibg = "#1A1B26",
		guifg = "#A9B1D6"
	},
	-- timer refresh rate
	interval = 300,
	-- filetype in the list, will not be executed
	no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest", "NvimTree" },
	-- Split line symbol definition
	symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
	close_event = function()
		-- Executed after closing the window divider
	end,
	create_event = function()
		-- Executed after creating the window divider
		--[[ if fn.winnr('$') == 3 then
			local win_id = fn.win_getid(vim.fn.winnr('h'))
			local filetype = api.nvim_buf_get_option(api.nvim_win_get_buf(win_id), 'filetype')
			if filetype == "NvimTree" then
				colorful_winsep.NvimSeparatorDel()
			end
		end ]]
	end
})
