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
        keywords = { italic = false, bold = true },
        functions = { italic = true, bold = true },
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "night", -- style for sidebars, see below
        floats = "night", -- style for floating windows
    },
	day_brightness = 0.2, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
    sidebars = { "qf", "help", "packer" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
    hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.

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
        -- TODO: Config normal highlight for each colorscheme
		-- local black = "#000000"
		-- hl.LineNr = { fg = "#697094" }
		-- hl.CursorLineNr = { fg = "#fefe14" , bold = true }
	end,
})

local theme = require("plugin.colorscheme").get_option()
if theme.colorscheme ~= "tokyonight" then return end

require("plugin.colorscheme").set_option() -- load option and colorscheme
