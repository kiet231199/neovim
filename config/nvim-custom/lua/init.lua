-- Dont list quickfix buffers
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.opt_local.buflisted = false
	end,
})

-- Load options
require("options")

-- Load plugins
require("plugin")

-- Load keymaps
require("utils").load_mappings()

-- Override highlights
require("utils").load_highlights()
