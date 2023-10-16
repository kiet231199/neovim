local colors = {}

local tokyonight = {
	black         = "#1a1b26",
	black2        = "#1f2336",
	blue          = "#7aa2f7",
	red           = "#f7768e",
	green         = "#9ece6a",
	yellow        = "#e0af68",
	orange        = "#ff9e64",
	baby_pink     = "#DE8C92",
	purple        = "#bb9af7",
	white         = "#c0caf5",
	cyan          = "#7dcfff",
	vibrant_green = "#73daca",
	teal          = "#1abc9c",
}
local monokai = {
	black         = "#1e1e1e",
	black2        = "#2f302a",
	blue          = "#51afef",
	red           = "#e36d76",
	green         = "#96c367",
	yellow        = "#e6c181",
	orange        = "#d39467",
	baby_pink     = "#f98385",
	purple        = "#c885d7",
	white         = "#f5f4f1",
	cyan          = "#41afef",
	vibrant_green = "#99c366",
	teal          = "#34bfd0",
}

local default, options = pcall(require, "plugin.colorscheme")
if not default then
	colors = tokyonight -- set tokyonight as default
else
	local theme = options.get_option().colorscheme
	if theme == "monokai-nightasty" then
		colors = monokai
	else
		colors = tokyonight
	end
end

local highlights = {
	common = {
		["NvChHeading"] = {
			fg = colors.black,
			bg = colors.blue,
			bold = true,
		},
		["NvChSection"] = {
			bg = colors.black2,
		},
		["NvChAsciiHeader"] = {
			fg = colors.blue,
		},
		["NvChHeadblue"] = {
			fg = colors.black,
			bg = colors.blue,
			bold = true,
		},
		["NvChHeadred"] = {
			fg = colors.black,
			bg = colors.red,
			bold = true,
		},
		["NvChHeadgreen"] = {
			fg = colors.black,
			bg = colors.green,
			bold = true,
		},
		["NvChHeadyellow"] = {
			fg = colors.black,
			bg = colors.yellow,
			bold = true,
		},
		["NvChHeadorange"] = {
			fg = colors.black,
			bg = colors.green,
			bold = true,
		},
		["NvChHeadbaby_pink"] = {
			fg = colors.black,
			bg = colors.baby_pink,
			bold = true,
		},
		["NvChHeadpurple"] = {
			fg = colors.black,
			bg = colors.purple,
			bold = true,
		},
		["NvChHeadwhite"] = {
			fg = colors.black,
			bg = colors.white,
			bold = true,
		},
		["NvChHeadcyan"] = {
			fg = colors.black,
			bg = colors.cyan,
			bold = true,
		},
		["NvChHeadvibrant_green"] = {
			fg = colors.black,
			bg = colors.vibrant_green,
			bold = true,
		},
		["NvChHeadteal"] = {
			fg = colors.black,
			bg = colors.teal,
			bold = true,
		},
	},
}

return highlights
