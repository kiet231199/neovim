-- INFO: All override highlight groups are defined in plugin/colorscheme/<colorscheme_name>/highlights.lua
local highlights = require("plugin.colorscheme").get_highlights()

vim.api.nvim_create_user_command(
	"ToggleBackground",
	function()
		require("plugin.colorscheme").toggle_background()
	end,
	{ desc = "switch light/dark background mode" })

return highlights
