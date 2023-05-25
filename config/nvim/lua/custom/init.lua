-- Load options
require("custom.options")

-- Local plugins -------------------------------------------------------------------
-- Desc: Dynamic winbar
require('custom.plugin.winbar').setup()
vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost' }, {
	once = true,
	group = vim.api.nvim_create_augroup('WinBarSetup', {}),
	callback = function()
		local api = require('custom.plugin.winbar.api')
		vim.keymap.set('n', '<space>w', api.pick)
	end,
})

-- Public plugins ------------------------------------------------------------------
local plugins = {}

plugins= require("custom.config")

return plugins
