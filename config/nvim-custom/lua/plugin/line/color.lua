local api = {}

local modes = {
    tokyonight = {
        n   = "#7aa2f7",
        i   = "cyan",
        v   = "#5c87eb",
        c   = "#3acaba",
        s   = "purple",
        r   = "#3acaba",
        na1 = "purple",   -- \19
        na2 = "cyan",     -- \22
        na3 = "pink",     -- \!
        t   = "pink",
    },
    monokai = {
        n   = "#a5e400",
        i   = "red",
        v   = "yellow",
        c   = "orange",
        s   = "green",
        r   = "#a5e400",
        na1 = "orange",   -- \19
        na2 = "orange",   -- \22
        na3 = "orange",   -- \!
        t   = "#a5e400",
    },
    default = {
        n   = "Black",
        i   = "Black",
        v   = "Black",
        c   = "Black",
        s   = "Black",
        r   = "Black",
        na1 = "Black",    -- \19
        na2 = "Black",    -- \22
        na3 = "Black",    -- \!
        t   = "Black",
    },
}

local colors = {
    tokyonight = {
        light = {
            primary   = { fg = "#b9cdeb", bg = "#2e7de9" },
            secondary = { fg = "#4b88e1", bg = "#a8aecb" },
            tertiary  = { fg = "#7583b8", bg = "#d4d6e4" },
            normal    = { fg = "#7583b8", bg = "#d4d6e4" },
        },
        dark = {
            primary   = { fg = "#15161e", bg = "#7aa2f7" },
            secondary = { fg = "#0c1220", bg = "#616da0" },
            tertiary  = { fg = "#5c87eb", bg = "#3b4261" },
            normal    = { fg = "#c0caf5", bg = "#16161e" },
        },
    },
    monokai = {
        light = {
            primary   = { fg = "#fdfef0", bg = "#4fb000" },
            secondary = { fg = "#191d26", bg = "#c0c0c0" },
            tertiary  = { fg = "#34373b", bg = "#d5d5d5" },
            normal    = { fg = "#34373b", bg = "#d5d5d5" },
        },
        dark = {
            primary   = { fg = "#001000", bg = "#a5e400" },
            secondary = { fg = "#8bb50a", bg = "#313131" },
            tertiary  = { fg = "#b6bdb9", bg = "#444444" },
            normal    = { fg = "#b6bdb9", bg = "#121212" },
        },
    },
    default = {
        light = {
            primary   = { fg = "Yellow", bg = "Black" },
            secondary = { fg = "Yellow", bg = "Black" },
            tertiary  = { fg = "Yellow", bg = "Black" },
            normal    = { fg = "Yellow", bg = "Black" },
        },
        dark = {
            primary   = { fg = "Yellow", bg = "Black" },
            secondary = { fg = "Yellow", bg = "Black" },
            tertiary  = { fg = "Yellow", bg = "Black" },
            normal    = { fg = "Yellow", bg = "Black" },
        },
    }
}

api.get_colors = function()
    local options = require("plugin.colorscheme").get_option() -- Get colorscheme options
    local new_colors = {}
    if options.colorscheme == "tokyonight" then
        new_colors = colors.tokyonight
    elseif options.colorscheme == "monokai-nightasty" then
        new_colors = colors.monokai
    else
        new_colors = colors.default
    end
    if options.background == "light" then return new_colors.light
    else return new_colors.dark end
end

api.get_mode_colors = function()
    local options = require("plugin.colorscheme").get_option() -- Get colorscheme options
    local new_colors = {}
    local new_fg
    if options.colorscheme == "tokyonight" then
        return modes.tokyonight
    elseif options.colorscheme == "monokai-nightasty" then
        return modes.monokai
    else
        new_colors = modes.default
        if options.background == "light" then new_fg = "black"
        else new_fg = "white" end
        for index in 1, #new_colors, 1 do
            new_colors[index] = new_fg
        end
    end
    return new_colors
end

return api
