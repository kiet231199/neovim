local status_ok, foldsign = pcall(require, "nvim-foldsign")
if not status_ok then
	print("Error: foldsign")
	return
end

foldsign.setup({
	offset = -2,
	foldsigns = {
		open = '',          -- mark the beginning of a fold
		close = '',         -- show a closed fold
		seps = { '⎹', '⎹' }, -- open fold middle marker
	}
})
