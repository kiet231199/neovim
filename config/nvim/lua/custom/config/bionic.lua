local status_ok, bionicreading = pcall(require, "bionic-reading")
if not status_ok then
	print("Error: bionic-reading")
	return
end

bionicreading.setup({
	auto_highlight = true,
	-- the file types you want to highlight
	file_types = { 'text', 'log', 'markdown' },
	hl_group_value = {
		link = "Bold",
	},
	-- dictates the characters highlighted based
	-- off of word length. key is word length and
	-- value is the number of characters highlighted
	-- note used if syllable_algorithm is on
	hl_offsets = {
		['1'] = 1,
		['2'] = 1,
		['3'] = 1,
		['4'] = 2,
		['default'] = 0.2, -- defaults to 40% of the word
	},
	-- Flag used to control if the user is prompted
	-- if BRToggle is called on a file type that is not
	-- explicitly defined above
	prompt_user = true,
	-- The cadence of highlight word. Defaults to ever
	-- word. Example: 2 would be every other word
	saccade_cadence = 1,
	-- Flag used to control if the highlighting is
	-- applied while typing
	update_in_insert_mode = true,
	-- Flag used to dicate if the syllable_algorithm
	-- is used. Highlights on syllables instead of
	-- characters based on word length. Disables the
	-- use of hl_offset if on
	syllable_algorithm = true,
})

