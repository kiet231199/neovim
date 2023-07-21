-- Syntax vim.api.nvim_set_hl(0, "Group", { fg = "#RGB, bg = "#RGB", bold = true ?, italic = true ?, reverse = true ?, link = "OtherGroup" })

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
		-- Split color line
		["SwapSplitStatusLine"]          = { fg = "Black", bg = "Red", bold = true },
		-- Scrollview
		["ScrollView"]                   = { bg = "#494C63" },
		["ScrollViewCursor"]             = { fg = "#bb9af7" },
		["ScrollViewDiagnosticsError"]   = { fg = "#f70067" },
		["ScrollViewDiagnosticsWarn"]    = { fg = "#f79000" },
		["ScrollViewDiagnosticsInfo"]    = { fg = "#a9ff68" },
		["ScrollViewDiagnosticsHint"]    = { fg = "#1abc9c" },
		["ScrollViewFolds"]              = { fg = "#7aa2f7" },
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
		-- Trouble
		["TroubleTextInformation"]       = { link = "DiagnosticVirtualTextInfo" },
		["TroubleTextError"]             = { link = "DiagnosticError" },
		["TroubleTextWarning"]           = { link = "DiagnosticWarning" },
		["TroubleTextHint"]              = { link = "DiagnosticHint" },
		-- Telescope
		["TelescopeMatching"]            = { fg = "Orange", bold = true },
		["TelescopePreviewMatch"]        = { fg = "Red", bg = "#1a1b26", bold = true },
		-- Cmp
		["CmpItemAbbrMatch"]             = { fg = "Orange", bold = true },
		["CmpItemAbbrMatchDefault"]      = { fg = "Orange", bold = true },
		["CmpItemAbbrMatchFuzzy"]        = { fg = "Red", bold = true },
		["CmpItemAbbrMatchFuzzyDefault"] = { fg = "Red", bold = true },
		["CmpItemKindText"]              = { fg = "Yellow", bold = true },
		-- Mininvim
		["MiniTrailspace"]               = { bg = "Red" },
		-- Notify
		["NotifyWARNBorder"]             = { fg = "#79491D" },
		["NotifyINFOBorder"]             = { fg = "#4F6752" },
		["NotifyDEBUGBorder"]            = { fg = "#8B8B8B" },
		["NotifyTRACEBorder"]            = { fg = "#4F3552" },
		["NotifyERRORIcon"]              = { fg = "#F70067" },
		["NotifyWARNIcon"]               = { fg = "#F79000" },
		["NotifyINFOIcon"]               = { fg = "#A9FF68" },
		["NotifyDEBUGIcon"]              = { fg = "#8B8B8B" },
		["NotifyTRACEIcon"]              = { fg = "#D484FF" },
		["NotifyERRORTitle"]             = { fg = "#F70067" },
		["NotifyWARNTitle"]              = { fg = "#F79000" },
		["NotifyINFOTitle"]              = { fg = "#A9FF68" },
		["NotifyDEBUGTitle"]             = { fg = "#8B8B8B" },
		["NotifyTRACETitle"]             = { fg = "#D484FF" },
		["NotifyERRORBody"]              = { link = "Normal" },
		["NotifyWARNBody"]               = { link = "Normal" },
		["NotifyINFOBody"]               = { link = "Normal" },
		["NotifyDEBUGBody"]              = { link = "Normal" },
		["NotifyTRACEBody"]              = { link = "Normal" },
		-- CodeWindow
		["CodewindowBorder"]             = { fg = "#ffff00" },
		-- IndentBlanklineIndent
		["IndentBlanklineIndent"]        = { fg = "#565f89" },
		["IndentBlanklineContextChar"]   = { fg = "#a9b1d6" },
		-- Telescope Promt
		["TelescopeResultsTitle"]        = { fg = "#1a1b26", bg = "#f7768e" },
		["TelescopePreviewTitle"]        = { fg = "#1a1b26", bg = "#bb9af7" },
		["TelescopePromptTitle"]         = { fg = "#1a1b26", bg = "#e0af68" },
		-- Dropbar
		["DropBarMenuCurrentContext"]    = { fg = "#03a4ff", bold = true },
		["DropBarIconUIPickPivot"]       = { fg = "Yellow", bold = true },
		["DropBarIconUISeparator"]       = { fg = "Orange", bold = true },
		["DropBarIconUISeparatorMenu"]   = { fg = "Red", bold = true },
		-- Flash
		["FlashLabel"]                   = { fg = "#7aa2f7", bold = true },
		["FlashCurrent"]                 = { fg = "Red", bold = true },
		["FlashMatch"]                   = { fg = "Yellow", bold = true },
		["FlashPrompt"]                  = { link = "Normal" },
		["FlashPromptIcon"]              = { link = "Normal" },
	}
}

return highlights
