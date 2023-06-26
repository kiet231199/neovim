local highlights = {
	-- Neovim common group
	common = {
		-- Popup
		["Pmenu"]                        = { bg = "#1a1b26" },
		["PmenuSel"]                     = { fg = "None", bg = "#292938" },
		["PmenuSbar"]                    = { bg = "#1a1b26" },
		["PmenuThumb"]                   = { fg = "#a9b1d6" },
		-- CursorLine
		["CursorLineNr"]                 = { fg = "Yellow", bold = true },
		-- Fold
		["Folded"]                       = { bg = "#1a1b26" },
		["FoldColumn"]                   = { fg = "#7aa2f7" },
		-- Winbar
		["WinBar"]                       = { link = "Title" },
	},
	-- Plugin group
	plugin = {
		-- NeoTree
		["NeoTreeFileNameOpened"]        = { fg = "#7aa2f7", bold = true },
		["NeoTreeIndentMarker"]          = { link = "Directory" },
		["NeoTreeExpander"]              = { link = "Directory" },
		-- Cmp
		["CmpItemAbbrMatch"]             = { fg = "Orange", bold = true },
		["CmpItemAbbrMatchDefault"]      = { fg = "Orange", bold = true },
		["CmpItemAbbrMatchFuzzy"]        = { fg = "Red", bold = true },
		["CmpItemAbbrMatchFuzzyDefault"] = { fg = "Red", bold = true },
		["CmpItemKindText"]              = { fg = "Yellow", bold = true },
		-- Scrollview
		["ScrollView"]                   = { bg = "#494C63" },
		["ScrollViewCursor"]             = { fg = "#bb9af7", bg = "None" },
		["ScrollViewDiagnosticsError"]   = { fg = "#f70067", bg = "None" },
		["ScrollViewDiagnosticsWarn"]    = { fg = "#f79000", bg = "None" },
		["ScrollViewDiagnosticsInfo"]    = { fg = "#a9ff68", bg = "None" },
		["ScrollViewDiagnosticsHint"]    = { fg = "#1abc9c", bg = "None" },
		["ScrollViewFolds"]              = { fg = "#7aa2f7", bg = "None" },
		["ScrollViewSearch"]             = { fg = "Red", bg = "None", bold = true },
		-- Gitsigns
		["GitSignsCurrentLineBlame"]     = { fg = "Yellow", bg = "#1a1b26" },
		["GitSignsAdd"]                  = { fg = "Green" },
		["GitSignsAddNr"]                = { fg = "Green" },
		["GitSignsChange"]               = { fg = "Yellow" },
		["GitSignsChangeNr"]             = { fg = "Yellow" },
		["GitSignsDelete"]               = { fg = "Red" },
		["GitSignsDelteNr"]              = { fg = "Red" },
		-- HlSearch
		["HlSearchNear"]                 = { link = "IncSearch" },
		["HlSearchLens"]                 = { fg = "#fbc7f1", bg = "#1a1b26" },
		["HlSearchLensNear"]             = { fg = "Red", bg = "#1a1b26", bold = true },
		["HlSearchFloat"]                = { link = "IncSearch" },
		-- IndentBlanklineIndent
		["IndentBlanklineIndent"]        = { fg = "#565f89" },
		["IndentBlanklineContextChar"]   = { fg = "#a9b1d6" },
		-- Telescope Promt
		["TelescopeResultsTitle"]        = { fg = "#1a1b26", bg = "#f7768e" },
		["TelescopePreviewTitle"]        = { fg = "#1a1b26", bg = "#bb9af7" },
		["TelescopePromptTitle"]         = { fg = "#1a1b26", bg = "#e0af68" },
	},
}

return highlights
