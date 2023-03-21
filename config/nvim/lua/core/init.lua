-- Dont list quickfix buffers
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.opt_local.buflisted = false
	end,
})

require("core.options")
require("core.plugins")
