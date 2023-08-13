local status_ok, multicolumn = pcall(require, "multicolumn")
if not status_ok then
	print("Error: multicolumn")
	return
end

multicolumn.setup({
	start = 'enabled',
	base_set = {
		scope = 'line',
		rulers = {},
		to_line_end = true,
		full_column = true,
		always_on = false,
		bg_color = nil,
		fg_color = nil,
	},
	sets = {
		default = {
			rulers = { 80 },
		},
	},
	line_limit = 300,
	exclude_floating = true,
	exclude_ft = { 'alpha', 'help' },
})
