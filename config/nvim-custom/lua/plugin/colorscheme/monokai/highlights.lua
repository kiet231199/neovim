-- Syntax vim.api.nvim_set_hl(0, "Group", { fg = "#RGB, bg = "#RGB", bold = true ?, italic = true ?, reverse = true ?, link = "OtherGroup" })

local light = {}

local dark = {}

local highlights = {
	light = light,
	dark = dark,
}

return highlights
