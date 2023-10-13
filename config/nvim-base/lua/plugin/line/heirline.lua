local status_ok, heirline = pcall(require, "heirline")
if not status_ok then
	print("Error: heirline")
	return
end

local utils = require("heirline.utils")
local colors = require("plugin.line.color")
local function setup_colors()
    local my_colors = colors.get_colors()
    local my_modes = colors.get_mode_colors()
    return {
        -- We need to do something here for each colorscheme
        primary_fg   = my_colors.primary.fg,
        primary_bg   = my_colors.primary.bg,
        secondary_fg = my_colors.secondary.fg,
        secondary_bg = my_colors.secondary.bg,
        tertiary_fg  = my_colors.tertiary.fg,
        tertiary_bg  = my_colors.tertiary.bg,
        normal_fg    = my_colors.normal.fg,
        normal_bg    = my_colors.normal.bg,
        mode_n       = my_modes.n,
        mode_i       = my_modes.i,
        mode_v       = my_modes.v,
        mode_c       = my_modes.c,
        mode_s       = my_modes.s,
        mode_r       = my_modes.r,
        mode_na1     = my_modes.na1,
        mode_na2     = my_modes.na2,
        mode_na3     = my_modes.na3,
        mode_t       = my_modes.t,
    }
end

vim.api.nvim_create_augroup("Heirline", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        utils.on_colorscheme(setup_colors)
    end,
    group = "Heirline",
})

local statusline = require("plugin.line.statusline")
local bufferline = require("plugin.line.bufferline")

heirline.setup({
    statusline = statusline,
    tabline = bufferline,
    opts = {
        colors = setup_colors,
        disable_winbar_cb = true,
    },
})
