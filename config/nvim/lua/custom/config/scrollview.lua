local status_ok, scrollview = pcall(require, "scrollview")
if not status_ok then
	print("Error: scrollview")
	return
end

scrollview.setup({
	zindex = 30,
	winblend = 50,
	base = 'right',
	column = 2,
	current_only = true,
	hide_on_intersect = false,
	line_limit = 5000,
	signs_max_per_row = 0,
	signs_column = 1,
	signs_show_in_folds = true,
	signs_zindex = 15,
	diagnostics_error_priority = 60,
	diagnostics_error_symbol = '',
	diagnostics_warn_priority = 50,
	diagnostics_warn_symbol = '',
	diagnostics_info_priority = 40,
	diagnostics_info_symbol = '',
	diagnostics_hint_priority = 30,
	diagnostics_hint_symbol = '',
	folds_priority = 30,
	folds_symbol = '󰄼',
	search_priority = 70,
	search_symbol = '',
})
