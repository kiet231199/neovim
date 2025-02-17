-- Dont list quickfix buffers
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.opt_local.buflisted = false
	end,
})

-- Set limitation for git commit
vim.api.nvim_create_autocmd("Filetype", {
	pattern = "gitcommit",
	command = "setlocal spell textwidth=72"
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	command = "silent! lua vim.highlight.on_yank({ timeout = 500 })",
	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
})

-- Check indent based on the current line
vim.api.nvim_create_autocmd('InsertEnter', {
	pattern = '*',
	callback = function()
		local line = vim.fn.getline('.')
		if line:match('^\t') then
			vim.bo.expandtab = false
		else
			vim.bo.expandtab = true
		end
	end,
})

