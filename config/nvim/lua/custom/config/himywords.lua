local status_ok, himywords = pcall(require, "hi-my-words")
if not status_ok then
	print("Error: hi-my-words")
	return
end

himywords.setup({
	silent = false,
	hl_grps = {
		{
			"HiMyWordsHLG0",
			{ fg = "Black", bg = "Red", bold = true, italic = false },
		},
		{
			"HiMyWordsHLG1",
			{ fg = "Black", bg = "#ff007c", bold = true, italic = false },
		},
		{
			"HiMyWordsHLG2",
			{ fg = "Black", bg = "Yellow", bold = true, italic = false },
		},
		{
			"HiMyWordsHLG3",
			{ fg = "Black", bg = "#73daca", bold = true, italic = false },
		},
		{
			"HiMyWordsHLG4",
			{ fg = "Black", bg = "#4829e4", bold = true, italic = false },
		},
		{
			"HiMyWordsHLG5",
			{ fg = "Black", bg = "#9d7cd8", bold = true, italic = false },
		},
		{
			"HiMyWordsHLG6",
			{ fg = "Black", bg = "Purple", bold = true, italic = false },
		},
		{
			"HiMyWordsHLG7",
			{ fg = "Black", bg = "White", bold = true, italic = false },
		},
		-- {
		-- 	"HiMyWordsHLG8",
		-- 	{ fg = "#408ec6", bg = "#1e2761", bold = true, italic = true },
		-- },
		-- {
		-- 	"HiMyWordsHLG9",
		-- 	{ fg = "#990011", bg = "#fcf6f5", bold = true, italic = true },
		-- },
	}
})
