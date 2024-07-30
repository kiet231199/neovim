local gitmessage = {
	-- Popup configure
	git_messenger_no_default_mappings = true,
	git_messenger_floating_win_opts = { border = 'rounded' },
	git_messenger_include_diff = "all",
	git_messenger_close_on_cursor_moved = false,
	git_messenger_always_into_popup = true,
	git_messenger_max_popup_height = 30,
	git_messenger_max_popup_width = 120,
	-- Example: '2019 May 26 03:27:43'
	git_messenger_date_format = "%Y %b %d %X",
}

for k,v in pairs(gitmessage) do
	vim.g[k] = v
end
