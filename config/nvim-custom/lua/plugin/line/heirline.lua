local status_ok, heirline = pcall(require, "heirline")
if not status_ok then
	print("Error: heirline")
	return
end

local statusline = require("plugin.line.statusline")
local bufferline = require("plugin.line.bufferline")

heirline.setup({
    statusline = statusline,
    tabline = bufferline,
    opts = {
        disable_winbar_cb = true,
    },
})

