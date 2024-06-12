local status_ok, blame = pcall(require, "blame")
if not status_ok then
	print("Error: blame")
	return
end

local window_view = require("blame").views.window_view
local virtual_view = require("blame").views.virtual_view
local formats = require("blame").formats.default_formats

blame.setup({
	date_format = "%Y-%m-%d",
	virtual_style = "right",
	views = {
		window = window_view,
		virtual = virtual_view,
		default = window_view,
	},
	merge_consecutive = false,
	max_summary_width = 30,
	colors = nil,
	commit_detail_view = "vsplit",
	format_fn = formats.commit_date_author_fn,
	mappings = {
		commit_info = "i",
		stack_push = "<TAB>",
		stack_pop = "<BS>",
		show_commit = "<CR>",
		close = { "<esc>", "q" },
	}
})
