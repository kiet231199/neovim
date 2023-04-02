local status_ok, smartcolumn = pcall(require, "smartcolumn")
if not status_ok then
	print("Error: smartcolumn")
	return
end

smartcolumn.setup({
	colorcolumn = "80",
	disabled_filetypes = { "alpha", "lazy", "txt", "md" },
	custom_colorcolumn = {},
	scope = "file",
})
