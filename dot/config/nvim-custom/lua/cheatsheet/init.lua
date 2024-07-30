vim.g.nvcheatsheet_displayed = false
local theme = "grid" -- "grid" or "simple"

-- load highlight
local cheatsheethl = require("cheatsheet.color")
if type(cheatsheethl) == "table" then
	for _, options_table in pairs(cheatsheethl) do
		for name, options in pairs(options_table) do
			vim.api.nvim_set_hl(0, name, options)
		end
	end
end

-- command to toggle cheatsheet
vim.api.nvim_create_user_command("NvCheatsheet", function()
	if vim.g.nvcheatsheet_displayed then
		require("cheatsheet.api").close_buffer()
	else
		require("cheatsheet." .. theme)()
	end
end, {})

-- redraw dashboard on VimResized event
vim.api.nvim_create_autocmd("VimResized", {
	callback = function()
		if vim.bo.filetype == "nvcheatsheet" then
			vim.opt_local.modifiable = true
			vim.api.nvim_buf_set_lines(0, 0, -1, false, { "" })
			require("cheatsheet." .. theme)()
		end
	end,
})
