local status_ok, heirline = pcall(require, "heirline")
if not status_ok then
	print("Error: heirline")
	return
end

local utils = require("heirline.utils")
local function setup_colors()
    return {
        -- We need to do something here for each colorscheme
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
