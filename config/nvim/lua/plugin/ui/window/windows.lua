vim.o.winwidth = 10
vim.o.winminwidth = 10
vim.o.equalalways = false

-- Disable when using with Floaterm
vim.api.nvim_create_autocmd("TermOpen", { command = "WindowsDisableAutowidth", })
vim.api.nvim_create_autocmd("TermClose", { command = "WindowsEnableAutowidth", })

local status_ok, windows = pcall(require, "windows")
if not status_ok then
	print("Error: windows")
	return
end

windows.setup({
	autowidth = {
		enable = false,
		winwidth = 25,
		filetype = {
			help = 2,
		},
	},
	ignore = {
		buftype = { "quickfix" },
		filetype = { "undotree", "gundo", "Outline", "easy-replace" }
	},
	animation = {
		enable = true,
		duration = 300,
		fps = 60,
		easing = "in_out_sine"
	}
})

