local status_ok, bionicreading = pcall(require, "bionic-reading")
if not status_ok then
	print("Error: bionic-reading")
	return
end

bionicreading.setup({
	auto_highlight = true,
	-- the file types you want to highlight with the node types you would like to target using treesitter
	file_types = {
		["text"] = {
			"any",
		},
		["log"] = {
			"any",
		},
		["lua"] = {}
	},
	-- the highlighting styles applied IMPORTANT - if link is present, no other styles are applied
	hl_group_value = {
		link = "Bold",
	},
	-- Flag used to control if the user is prompted if BRToggle is called on a file type that is not explicitly defined above
	prompt_user = true,
	-- Enable or disable the use of treesitter
	treesitter = true,
	-- Flag used to control if highlighting is applied as you type
	update_in_insert_mode = true,
})

