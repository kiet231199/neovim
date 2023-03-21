local status_ok, tokyonight = pcall(require, "tokyonight")
if not status_ok then
	print("Error: tokyonight")
	return
end

tokyonight.setup({
    -- your configuration comes here
    -- or leave it empty to use the default settings
    style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
    transparent = false, -- Enable this to disable setting the background color
    terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
    styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = true, bold = true },
        functions = { italic = true, bold = true },
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "night", -- style for sidebars, see below
        floats = "night", -- style for floating windows
    },
    sidebars = { "qf", "help", "packer" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
    hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
    dim_inactive = true, -- dims inactive windows
    lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold

    -- You can override specific color groups to use other groups or a hex color
    -- function will be called with a ColorScheme table
    -- @param colors ColorScheme
    on_colors = function(colors)
        -- colors.hint = colors.orange
        -- colors.error = "#ff0000"
    end,

    -- You can override specific highlights to use other groups or a hex color
    -- function will be called with a Highlights and ColorScheme table
    -- @param highlights Highlights
    -- @param colors ColorScheme
    on_highlights = function(hl, cl)
		local black = "#000000"
		-- Common
		hl.WinSeparator = { fg = cl.magenta, bold = true }
		hl.LineNr = { fg = "#697094" }
		hl.CursorLineNr = { fg = "#fefe14" , bold = true }
		hl.IncSearch = { fg = black, bg = cl.red1 }
		hl.TabLineFill = { bg = "#13141c" }
		-- NvimTree
		hl.NvimTreeWinSeparator = { fg = "#a9b1d6" }
		hl.NvimTreeIndentMarker = { fg = "#a9b1d6" }
		hl.NvimTreeLspDiagnosticsError = { fg = cl.error }
		hl.NvimTreeLspDiagnosticsWarning = { fg = cl.warning }
		hl.NvimTreeLspDiagnosticsInformation = { fg = cl.info }
		hl.NvimTreeLspDiagnosticsHint = { fg = cl.hint }
		-- Telescope
		hl.TelescopePromptBorder = { fg = cl.yellow }
		hl.TelescopePreviewBorder = { fg = cl.magenta }
		hl.TelescopeResultsBorder = { fg = cl.red }
		hl.TelescopePromptTitle = { fg = cl.yellow }
		hl.TelescopePreviewTitle = { fg = cl.magenta }
		hl.TelescopeResultsTitle = { fg = cl.red }
		-- Whichkey
		hl.WhichKey = { fg = cl.yellow }
	end,
})
