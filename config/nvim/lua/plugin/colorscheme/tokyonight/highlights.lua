-- Syntax vim.api.nvim_set_hl(0, "Group", { fg = "#RGB, bg = "#RGB", bold = true ?, italic = true ?, reverse = true ?, link = "OtherGroup" })

local light = {}

local dark = {
    -- Neovim common group
    common = {
        -- Popup
        ["Pmenu"]                        = { bg = "#1a1b26" },
        ["PmenuSel"]                     = { fg = "None", bg = "#292938" },
        ["PmenuSbar"]                    = { bg = "#1a1b26" },
        ["PmenuThumb"]                   = { bg = "#a9b1d6" },
        -- CursorLine
        ["LineNr"]                       = { fg = "#697094" },
        ["CursorLineNr"]                 = { fg = "Yellow", bold = true },
        -- Fold
        ["Folded"]                       = { bg = "#1a1b26" },
        ["FoldColumn"]                   = { fg = "#7aa2f7" },
        -- Winbar
        ["WinBar"]                       = { link = "Title" },
        -- WinSeparator
        ["WinSeparator"]                 = { fg = "Magenta", bold = true },
        -- Search
        ["Search"]                       = { fg = "#faa2f7", bg = "#292e42", bold = true },
        ["IncSearch"]                    = { fg = "#13141c", bg = "#db4b4b", bold = true },
        -- TablineFill
        ["TabLineFill"]                  = { bg = "#13141c" },
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
        ["DropBarMenuFloatBorder"]       = { fg = "#7aa2f7" },
        -- Flash
        ["FlashLabel"]                   = { fg = "#7aa2f7", bold = true },
        ["FlashCurrent"]                 = { fg = "#db4b4b", bold = true },
        ["FlashMatch"]                   = { fg = "Yellow", bold = true },
        ["FlashPrompt"]                  = { link = "Normal" },
        ["FlashPromptIcon"]              = { link = "Normal" },
        -- Debugger
        ['DapBreakpoint']                = { fg = '#993939' },
        ['DapLogPoint']                  = { fg = '#61afef' },
        ['DapStopped']                   = { fg = '#98c379' },
		['LspSignatureActiveParameter']  = { fg = 'Yellow' },
		-- Multiple cursors
		['MultiCursor']                  = { fg = 'Black', bg = 'Yellow', bold = true },
		['MultiCursorMain']              = { fg = 'Black', bg = 'Yellow', bold = true },
		['GitGraphHash']                 = { fg = '#f7768e', bold = true },
		['GitGraphTimestamp']            = { link = "Comment" },
		['GitGraphAuthor']               = { fg = '#7aa2f7', bold = true },
		['GitGraphBranchName']           = { fg = '#73d9c9', bold = true },
		['GitGraphBranchTag']            = { fg = "#fb9c63", bold = true },
		['GitGraphBranchMsg']            = { fg = '#c0caf5' },
		['GitGraphBranch1']              = { fg = 'Red' },
		['GitGraphBranch2']              = { fg = 'Yellow' },
		['GitGraphBranch3']              = { fg = 'Magenta' },
		['GitGraphBranch4']              = { fg = 'Cyan' },
		['GitGraphBranch5']              = { fg = 'Green' },
    }
}

local highlights = {
	light = light,
	dark = dark,
}

return highlights
