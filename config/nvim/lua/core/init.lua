-- Dont list quickfix buffers
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.opt_local.buflisted = false
	end,
})

-- Load options
require("core.options")

-- Load plugins
require("core.config")
