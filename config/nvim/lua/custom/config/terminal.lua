local status_ok, terminal = pcall(require, "terminal")
if not status_ok then
	print("Error: terminal")
	return
end

terminal.setup({
	
})
