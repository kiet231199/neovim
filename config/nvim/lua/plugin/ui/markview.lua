local status_ok, markview = pcall(require, "markview")
if not status_ok then
	print("Error: markview")
	return
end

local presets = require("markview.presets").headings

markview.setup({
    preview = {
        enable = true,
        filetypes = { "markdown", "codecompanion" },
        ignore_buftypes = {},
        modes = { "n", "no", "c" },
        icon_provider = "devicons",
        debounce = 1000,
    },
    markdown = {
        headings = presets.arrowed,
        tables   = presets.rounded,
    },
})
