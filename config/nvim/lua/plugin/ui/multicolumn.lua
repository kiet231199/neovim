local status_ok, multicolumn = pcall(require, "multicolumn")
if not status_ok then
	print("Error: multicolumn")
	return
end

multicolumn.setup({
	start = 'enabled',
	base_set = {
		scope = 'line',
		rulers = { 80 },
		to_line_end = false,
		full_column = true,
		always_on = false,
		bg_color = "#13141c",
		fg_color = nil,
	},
	sets = {
		alpha = {
			rulers = { 0 },
		},
		nvcheatsheet = {
			rulers = { 0 },
		},
		git = {
			rulers = { 72 },
		},
		default = {
			rulers = { 80 },
		},
	},
	line_limit = 300,
	exclude_floating = true,
	exclude_ft = { 'alpha', 'help', 'markdown', 'netrw', 'snacks_picker_list', 'snacks_terminal', 'gitgraph' },
})
