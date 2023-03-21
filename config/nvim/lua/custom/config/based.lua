local status_ok, based = pcall(require, "based")
if not status_ok then
	print("Error: based")
	return
end

based.setup({
	highlight = "Comment"
})
-- vim.api.nvim_set_keymap("n", "<leader>bh", ":BasedConvert hex<CR>", { silent = true, noremap = true }) -- Convert from hex
-- vim.api.nvim_set_keymap("n", "<leader>bd", ":BasedConvert dec<CR>", { silent = true, noremap = true }) -- Convert from decimal
