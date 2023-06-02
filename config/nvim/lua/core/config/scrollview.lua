local status_ok, scrollview = pcall(require, "scrollview")
if not status_ok then
	print("Error: scrollview")
	return
end

scrollview.setup({
	mode = 'virtual',
	zindex = 30,
	winblend = 50,
	base = 'right',
	column = 2,
	current_only = true,
	hide_on_intersect = false,
	line_limit = 5000,
	signs_max_per_row = 0,
	signs_column = 1,
	signs_on_startup = {'search', 'diagnostics', 'folds' },
	signs_show_in_folds = true,
	signs_zindex = 45,
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

-- Add config with gitsigns
local group = 'gitsigns'
local add = scrollview.register_sign_spec({
	group = group,
	highlight = 'GitSignsAdd',
	symbol = ' ',
}).name
local change = scrollview.register_sign_spec({
	group = group,
	highlight = 'GitSignsChange',
	symbol = ' ',
}).name
local delete = scrollview.register_sign_spec({
	group = group,
	highlight = 'GitSignsDelete',
	symbol = ' ',
}).name

scrollview.set_sign_group_state(group, enable)

vim.api.nvim_create_autocmd('User', {
	pattern = 'ScrollViewRefresh',
	callback = function()
		if not scrollview.is_sign_group_active(group) then return end
		local success, gitsigns = pcall(require, 'gitsigns')
		if not success then return end
		for _, winid in ipairs(scrollview.get_sign_eligible_windows()) do
			local bufnr = vim.api.nvim_win_get_buf(winid)
			local hunks = gitsigns.get_hunks(bufnr) or {}
			local lines_add = {}
			local lines_change = {}
			local lines_delete = {}
			for _, hunk in ipairs(hunks) do
				if hunk.type == 'add' then
					-- Don't show if the entire column would be covered.
					if hunk.added.count < vim.api.nvim_buf_line_count(bufnr) then
						for line = hunk.added.start, hunk.added.start + hunk.added.count - 1 do
							table.insert(lines_add, line)
						end
					end
				elseif hunk.type == 'change' then
					for line = hunk.added.start, hunk.added.start + hunk.added.count - 1 do
						table.insert(lines_change, line)
					end
				elseif hunk.type == 'delete' then
					table.insert(lines_delete, hunk.added.start)
				end
			end
			vim.b[bufnr][add] = lines_add
			vim.b[bufnr][change] = lines_change
			vim.b[bufnr][delete] = lines_delete
		end
	end
})

vim.api.nvim_create_autocmd('User', {
	pattern = 'GitSignsUpdate',
	callback = function()
		if not scrollview.is_sign_group_active(group) then return end
		vim.cmd('ScrollViewRefresh')
	end
})
