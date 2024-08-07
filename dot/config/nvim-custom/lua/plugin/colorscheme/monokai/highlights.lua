-- Syntax vim.api.nvim_set_hl(0, "Group", { fg = "#RGB, bg = "#RGB", bold = true ?, italic = true ?, reverse = true ?, link = "OtherGroup" })

local light = {}

local dark = {
    -- Neovim common group
    common = {
        -- Popup
        ["Pmenu"]                        = { bg = "#121212" },
        ["PmenuSel"]                     = { fg = "None", bg = "#292938" },
        ["PmenuSbar"]                    = { bg = "#121212" },
        ["PmenuThumb"]                   = { fg = "#a9b1d6" },
		-- Fold
		["Folded"]                       = { bg = "#ae5400" },
		["FoldColumn"]                   = { fg = "#7aa2f7" },
        -- Winbar
        ["WinBar"]                       = { link = "Title" },
        -- WinSeparator
        ["WinSeparator"]                 = { fg = "Orange", bold = true },
        -- Search
        ["Search"]                       = { fg = "#b6bdb9", bg = "#444444", bold = true },
        ["IncSearch"]                    = { fg = "#1e1e1e", bg = "#db4b4b", bold = true },
		["Directory"]                    = { fg = "#a5e400" },
	},
    -- Plugin group
    plugin = {
        -- NeoTree
        ["NeoTreeFileNameOpened"]        = { fg = "#637a1c", bold = true },
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
        ["GitSignsCurrentLineBlame"]     = { fg = "Yellow", bg = "#292e42" },
        ["GitSignsAdd"]                  = { fg = "Green" },
        ["GitSignsAddNr"]                = { fg = "Green" },
        ["GitSignsChange"]               = { fg = "Yellow" },
        ["GitSignsChangeNr"]             = { fg = "Yellow" },
        ["GitSignsDelete"]               = { fg = "Red" },
        ["GitSignsDelteNr"]              = { fg = "Red" },
        -- HlSearch
        ["HlSearchNear"]                 = { link = "IncSearch" },
        ["HlSearchLens"]                 = { link = "Comment" },
        ["HlSearchLensNear"]             = { link = "IncSearch" },
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
        ["IblScope"]                     = { fg = "White" },
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
        ["FlashLabel"]                   = { fg = "#a5e400", bold = true },
        ["FlashCurrent"]                 = { fg = "Red", bold = true },
        ["FlashMatch"]                   = { fg = "Cyan", bold = true },
        ["FlashPrompt"]                  = { link = "Normal" },
        ["FlashPromptIcon"]              = { link = "Normal" },
        -- Drop
        ["Drop1"]                        = { fg = "#3a3920", bg = "#1a1b26", blend = 0 },
        ["Drop1Bold"]                    = { fg = "#3a3920", bg = "#1a1b26", bold = true, blend = 0 },
        ["Drop2"]                        = { fg = "#807622", bg = "#1a1b26", blend = 0 },
        ["Drop2Bold"]                    = { fg = "#807622", bg = "#1a1b26", bold = true, blend = 0 },
        ["Drop3"]                        = { fg = "#eaa724", bg = "#1a1b26", blend = 0 },
        ["Drop3Bold"]                    = { fg = "#eaa724", bg = "#1a1b26", bold = true, blend = 0 },
        ["Drop4"]                        = { fg = "#d25b01", bg = "#1a1b26", blend = 0 },
        ["Drop4Bold"]                    = { fg = "#d25b01", bg = "#1a1b26", bold = true, blend = 0 },
        ["Drop5"]                        = { fg = "#5b1c02", bg = "#1a1b26", blend = 0 },
        ["Drop5Bold"]                    = { fg = "#5b1c02", bg = "#1a1b26", bold = true, blend = 0 },
        ["Drop6"]                        = { fg = "#740819", bg = "#1a1b26", blend = 0 },
        ["Drop6Bold"]                    = { fg = "#740819", bg = "#1a1b26", bold = true, blend = 0 },
        -- Debugger
        ['DapBreakpoint']                = { fg = '#993939' },
        ['DapLogPoint']                  = { fg = '#61afef' },
        ['DapStopped']                   = { fg = '#98c379' },
		-- Noice
		['NoiceCmdlineIcon']             = { fg = '#8bb50a' },

    }
}

local highlights = {
	light = light,
	dark = dark,
}

return highlights
