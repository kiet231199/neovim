local highlights = {
	-- Neovim common group
	common = {
		-- Popup
		["Pmenu"] = { bg = "#1a1b26" },
		["PmenuSel"] = { fg = "None", bg = "#292938" },
		["PmenuSbar"] = { bg = "#1a1b26" },
		["PmenuThumb"] = { fg = "#a9b1d6" },
		-- CursorLine
		["CursorLineNr"] = { fg = "Yellow", bold = true },
	},
	-- Plugin group
	plugin = {
		-- Cmp
		["CmpItemAbbrMatch"] = { fg = "Orange", bold = true },
		["CmpItemAbbrMatchDefault"] = { fg = "Orange", bold = true },
		["CmpItemAbbrMatchFuzzy"] = { fg = "Red", bold = true },
		["CmpItemAbbrMatchFuzzyDefault"] = { fg = "Red", bold = true },
		["CmpItemKindText"] = { fg = "Yellow", bold = true },
		-- Scrollview
		["ScrollView"] = { fg = "#a9b1d6" },
		-- Gitsigns
		["GitSignsCurrentLineBlame"] = { fg = "Yellow", bg = "#1a1b26" },
		["GitSignsAdd"] = { fg = "Green" },
		["GitSignsAddNr"] = { fg = "Green" },
		["GitSignsChange"] = { fg = "Yellow" },
		["GitSignsChangeNr"] = { fg = "Yellow" },
		["GitSignsDelete"] = { fg = "Red" },
		["GitSignsDelteNr"] = { fg = "Red" },
		-- HlSearch
		["HlSearchNear"] = { link = "IncSearch" },
		["HlSearchLens"] = { fg = "#fbc7f1", bg = "#1a1b26" },
		["HlSearchLensNear"] = { fg = "Red", bg = "#1a1b26", bold = true },
		["HlSearchFloat"] = { link = "IncSearch" },
	},
}

return highlights
