local status_ok, blame = pcall(require, "blame")
if not status_ok then
	print("Error: blame")
	return
end

blame.setup({
	date_format = "%Y-%m-%d",
	virtual_style = "right",
	merge_consecutive = false,
	max_summary_width = 30,
	colors = nil,
	commit_detail_view = "vsplit",
	mappings = {
		commit_info = "i",
		stack_push = "<TAB>",
		stack_pop = "<BS>",
		show_commit = "<CR>",
		close = { "<esc>", "q" },
	}
})
