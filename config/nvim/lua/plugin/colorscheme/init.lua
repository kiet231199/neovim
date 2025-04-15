Api = {}

local option = {
    -- "tokyonight" only
    colorscheme = "tokyonight",
    -- "light", "dark"
    background = "dark",
}

Api.set_option = function()
    if option.colorscheme == "tokyonight" then
        vim.cmd("colorscheme tokyonight")
    end
    vim.g.colors_name = option.colorscheme
    vim.o.background = option.background
end

Api.get_option = function()
    return option
end

Api.get_highlights = function()
	local highlights = {}
    if option.colorscheme == "tokyonight" then
        highlights = require("plugin.colorscheme.tokyonight.highlights")
    end
    if option.background == "light" then return highlights.light
    else return highlights.dark end
end

Api.toggle_background = function()
    if option.background == "dark" then option.background = "light"
    else option.background = "dark" end
    vim.o.background = option.background
end

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
		-- From tokyonight v4.0.0, return value of vim.g.colors_name is "tokyonight-<style>"
		if string.find(vim.g.colors_name, "tokyonight") then
			option.colorscheme = "tokyonight"
		else
			option.colorscheme = vim.g.colors_name
		end
    end,
})

return Api
