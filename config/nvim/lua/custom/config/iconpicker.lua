local status_ok, iconpicker = pcall(require, "icon-picker")
if not status_ok then
	print("Error: icon-picker")
	return
end

iconpicker.setup({
	disable_legacy_commands = true
})

-- local opts = { noremap = true, silent = true }
--
-- vim.keymap.set("n", "<Leader><Leader>i", "<cmd>PickEverything<cr>", opts)
-- vim.keymap.set("n", "<Leader><Leader>y", "<cmd>PickEverythingYank<cr>", opts)
-- vim.keymap.set("i", "<A-i>", "<cmd>PickEverythingInsert<cr>", opts)
