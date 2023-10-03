api = {}

local option = {
    -- "tokyonight", "monokai-nightasty"
    colorscheme = "tokyonight",
    -- "light", "dark"
    background = "dark",
}

api.set_option = function()
    if option.colorscheme == "tokyonight" then
        vim.cmd("colorscheme tokyonight")
    end
    if option.colorscheme == "monokai-nightasty" then
        vim.cmd("colorscheme monokai-nightasty")
    end
    vim.g.colors_name = option.colorscheme
    vim.o.background = option.background
end

api.get_option = function()
    return option
end

api.toggle_background = function()
    if option.background == "dark" then option.background = "light"
    else option.background = "dark" end
    vim.o.background = option.background
end

vim.api.nvim_create_augroup("ColorSchemePost", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        option.colorscheme = vim.g.colors_name
        option.background = vim.o.background
    end,
    group = "ColorSchemePost",
})

return api
