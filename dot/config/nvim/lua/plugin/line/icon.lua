api = {}

local icons = {
    external = {
        left = '', right = '',
        -- left = '', right = '',
    },
    internal = {
        left_t = '', right = '',
        -- left = '', right = '',
    },
}

api.get_icon = function()
    return icons
end

return api
