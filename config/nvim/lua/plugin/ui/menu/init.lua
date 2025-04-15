Menu = {}

local border = true

Menu.open = function(mode)
    require("menu.utils").delete_old_menus()

    if mode == "normal" then
        local normal = require("plugin.ui.menu.normal")
        require("menu").open(normal, { border = border })
    elseif mode == "visual" then
        local visual = require("plugin.ui.menu.visual")
        require("menu").open(visual, { border = border })
    end
end

return Menu
