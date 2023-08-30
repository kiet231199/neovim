local status_ok, heirline = pcall(require, "heirline")
if not status_ok then
	print("Error: heirline")
	return
end

local get_hex = require('heirline/utils').get_highlight

local my_color = {
    primary = {
        fg = "#15161e",
        bg = "#7aa2f7",
    },
    secondary = {
        fg = "#5c87eb",
        bg = "#3b4261",
    },
    normal = {
        bg = "#13141c",
    },
}

local statusline = {
    {
        provider = " %f ",
        hl = {
            fg = get_hex("DiagnosticError").fg,
            bg = my_color.primary.bg,
        },
    },
    {
        provider = "%p %)",
    },
}

heirline.setup({
    statusline = statusline,
    opts = {
        disable_winbar_cb = true,
    },
})
