local status_ok, scrollview = pcall(require, "scrollview")
if not status_ok then
	print("Error: scrollview")
	return
end

scrollview.setup({
	always_show = true,
	excluded_filetypes = { 'snacks_picker_list', 'lspsagaoutline', 'alpha', 'nvcheatsheet' },
	mode = 'virtual',
	zindex = 30,
	winblend = 50,
	base = 'right',
	column = 2,
	current_only = true,
	hide_on_intersect = false,
	hover = true,
	line_limit = 5000,
	signs_max_per_row = 1,
	signs_column = 1,
	signs_on_startup = {'search', 'diagnostics', 'folds', 'cursor' },
	signs_show_in_folds = true,
	signs_zindex = 45,
	cursor_priority = 100,
	cursor_symbol = '󰄽',
	diagnostics_error_priority = 60,
	diagnostics_error_symbol = '▪',
	diagnostics_warn_priority = 50,
	diagnostics_warn_symbol = '▪',
	diagnostics_hint_priority = 40,
	diagnostics_hint_symbol = '󰧞',
	diagnostics_info_priority = 30,
	diagnostics_info_symbol = '󰧞',
	folds_priority = 30,
	folds_symbol = '󰄼',
	search_priority = 70,
	search_symbol = '',
})

